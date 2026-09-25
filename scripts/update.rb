#!/usr/bin/env ruby
# frozen_string_literal: true

# Collects the coding examples of the ZHdK-Critical-Coding organisation and
# turns them into the Jekyll collection `_examples`.
#
# A repository is listed on the page if it contains an `example.yaml`:
#
#   name: "Joystick"            # title shown on the page
#   date: 2026-09-16
#   author: Urs Hofer
#   technology: "P5.js"         # shown right of the title
#   category: input             # input | transformation | output
#   readme: "sub/readme.md"     # optional, default: README.md in the repo root
#   related: Servers_Pusher     # optional, repository name or list of names
#
# Usage:
#   bundle exec ruby scripts/update.rb                  # list + shallow-clone repos from GitHub
#   bundle exec ruby scripts/update.rb --local ../Examples  # use existing local clones instead
#
# Authentication (private repos): GITHUB_TOKEN or GH_TOKEN, otherwise the token
# stored in git's credential helper for github.com is used.

require "yaml"
require "json"
require "date"
require "net/http"
require "uri"
require "open3"
require "fileutils"
require "base64"
require "optparse"

ROOT        = File.expand_path("..", __dir__)
CONFIG      = YAML.safe_load(File.read(File.join(ROOT, "_config.yml")))
ORG         = CONFIG.fetch("github_org")
CATEGORIES  = CONFIG.fetch("example_categories")
SKIP_REPOS  = %w[ZHdK-Critical-Coding.github.io .github].map(&:downcase).freeze
OUT_DIR     = File.join(ROOT, "_examples")
ASSET_DIR   = File.join(ROOT, "assets", "examples")
CACHE_DIR   = File.join(ROOT, ".cache", "repos")
META_FILE   = "example.yaml"
IMAGE_EXT   = %w[.png .jpg .jpeg .gif .svg .webp .avif].freeze

options = {}
OptionParser.new do |o|
  o.banner = "Usage: ruby scripts/update.rb [--local DIR]"
  o.on("--local DIR", "Read repositories from local clones in DIR") { |d| options[:local] = File.expand_path(d) }
end.parse!

# ---------------------------------------------------------------- helpers

def run(*cmd)
  out, err, status = Open3.capture3(*cmd)
  raise "#{cmd.reject { |c| c.start_with?("http.") }.join(" ")} failed: #{err.strip}" unless status.success?
  out
end

def github_token
  token = ENV["GITHUB_TOKEN"] || ENV["GH_TOKEN"]
  return token unless token.to_s.empty?

  out, _, status = Open3.capture3("git", "credential", "fill", stdin_data: "protocol=https\nhost=github.com\n\n")
  status.success? ? out[/^password=(.*)$/, 1] : nil
rescue Errno::ENOENT
  nil
end

def api_get(path, token)
  uri = URI("https://api.github.com#{path}")
  req = Net::HTTP::Get.new(uri)
  req["Accept"] = "application/vnd.github+json"
  req["Authorization"] = "Bearer #{token}" if token
  Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http| http.request(req) }
end

def org_repos(token)
  repos = []
  (1..).each do |page|
    res = api_get("/orgs/#{ORG}/repos?type=all&per_page=100&page=#{page}", token)
    raise "GitHub API: #{res.code} #{res.body}" unless res.is_a?(Net::HTTPSuccess)

    batch = JSON.parse(res.body)
    repos.concat(batch)
    break if batch.size < 100
  end
  repos.reject { |r| r["archived"] || SKIP_REPOS.include?(r["name"].downcase) }.sort_by { |r| r["name"].downcase }
end

def has_meta_file?(repo, token)
  api_get("/repos/#{ORG}/#{repo["name"]}/contents/#{META_FILE}?ref=#{repo["default_branch"]}", token)
    .is_a?(Net::HTTPSuccess)
end

# Shallow clone or refresh a repository in .cache/repos
def sync_repo(repo, token)
  dir  = File.join(CACHE_DIR, repo["name"])
  auth = token ? ["-c", "http.https://github.com/.extraheader=AUTHORIZATION: basic #{Base64.strict_encode64("x-access-token:#{token}")}"] : []
  branch = repo["default_branch"]
  if File.directory?(File.join(dir, ".git"))
    run("git", *auth, "-C", dir, "fetch", "--quiet", "--depth", "1", "origin", branch)
    run("git", "-C", dir, "reset", "--quiet", "--hard", "FETCH_HEAD")
  else
    FileUtils.mkdir_p(CACHE_DIR)
    run("git", *auth, "clone", "--quiet", "--depth", "1", "--branch", branch, repo["clone_url"], dir)
  end
  dir
end

def local_repos(base)
  Dir.children(base).sort_by(&:downcase).filter_map do |name|
    dir = File.join(base, name)
    next unless File.directory?(File.join(dir, ".git"))

    remote = (run("git", "-C", dir, "remote", "get-url", "origin").strip rescue "")
    {
      "name" => name,
      "dir" => dir,
      "html_url" => remote.empty? ? "https://github.com/#{ORG}/#{name}" : remote.sub(/\.git\z/, ""),
      "default_branch" => run("git", "-C", dir, "branch", "--show-current").strip
    }
  end
end

def slugify(name)
  name.downcase.gsub(/[^a-z0-9]+/, "-").gsub(/\A-|-\z/, "")
end

def find_readme(dir, meta)
  if meta["readme"]
    path = File.join(dir, meta["readme"])
    return path if File.file?(path)
  end
  root = Dir.children(dir).find { |f| f.casecmp?("readme.md") }
  return File.join(dir, root) if root

  Dir.glob(File.join(dir, "*", "*"), File::FNM_CASEFOLD)
     .reject { |f| f.include?("node_modules") }
     .find { |f| File.basename(f).casecmp?("readme.md") }
end

# Rewrites relative links in the README: images are copied into
# assets/examples/<slug>/, everything else points to the file on GitHub.
def rewrite_links(markdown, readme_path, repo_dir, repo, slug)
  readme_dir = File.dirname(readme_path)
  in_fence = false

  rewrite = lambda do |target, image|
    return target if target.empty? || target.match?(%r{\A(?:[a-z][a-z0-9+.-]*:|#|/)}i)

    path, anchor = target.split("#", 2)
    file = File.expand_path(URI.decode_www_form_component(path.gsub("+", "%2B")), readme_dir)
    return target unless file.start_with?(repo_dir)

    rel = file.delete_prefix("#{repo_dir}/")
    encoded = rel.split("/").map { |p| URI.encode_www_form_component(p).gsub("+", "%20") }.join("/")
    if image && File.file?(file) && IMAGE_EXT.include?(File.extname(file).downcase)
      dest = File.join(ASSET_DIR, slug, rel)
      FileUtils.mkdir_p(File.dirname(dest))
      FileUtils.cp(file, dest)
      "../../assets/examples/#{slug}/#{encoded}"
    else
      kind = File.directory?(file) ? "tree" : "blob"
      "#{repo["html_url"]}/#{kind}/#{repo["default_branch"]}/#{encoded}#{anchor ? "##{anchor}" : ""}"
    end
  end

  markdown.each_line.map do |line|
    if line.match?(/\A\s*(```|~~~)/)
      in_fence = !in_fence
      next line
    end
    next line if in_fence

    line
      .gsub(/(!?)\[([^\]]*)\]\(\s*<([^>]+)>/) { "#{$1}[#{$2}](<#{rewrite.call($3, $1 == "!")}>" }
      .gsub(/(!?)\[([^\]]*)\]\(\s*([^)\s<]+)/) { "#{$1}[#{$2}](#{rewrite.call($3, $1 == "!")}" }
      .gsub(/\b(src|href)=(["'])([^"']+)\2/) { "#{$1}=#{$2}#{rewrite.call($3, $1 == "src")}#{$2}" }
  end.join
end

# Replaces the first H1 (outside code fences) with "# Technology: Name",
# or prepends one if the README has no H1.
def normalize_title(markdown, title)
  lines = markdown.lines
  fence = false
  index = lines.index do |line|
    fence = !fence if line.start_with?("```", "~~~")
    !fence && line.match?(/\A# \S/)
  end
  return "# #{title}\n\n#{markdown}" unless index

  lines[index] = "# #{title}\n"
  lines.join
end

# ---------------------------------------------------------------- main

token = github_token
repos =
  if options[:local]
    local_repos(options[:local])
  else
    warn "No GitHub token found – only public repositories will be visible." unless token
    org_repos(token)
  end

FileUtils.rm_rf(OUT_DIR)
FileUtils.rm_rf(ASSET_DIR)
FileUtils.mkdir_p(OUT_DIR)

report = Hash.new { |h, k| h[k] = [] }

repos.each do |repo|
  name = repo["name"]
  if options[:local]
    dir = repo["dir"]
    unless File.file?(File.join(dir, META_FILE))
      report[:no_yaml] << name
      next
    end
  else
    unless has_meta_file?(repo, token)
      report[:no_yaml] << name
      next
    end
    print "  pulling #{name} … "
    begin
      dir = sync_repo(repo, token)
      puts "ok"
    rescue StandardError => e
      puts "failed"
      report[:errors] << "#{name}: #{e.message}"
      next
    end
  end

  begin
    meta = YAML.safe_load(File.read(File.join(dir, META_FILE)), permitted_classes: [Date]) || {}
  rescue Psych::Exception => e
    report[:errors] << "#{name}: #{META_FILE} is not valid YAML (#{e.message})"
    next
  end

  category = meta["category"].to_s.downcase.strip
  unless CATEGORIES.include?(category)
    report[:errors] << "#{name}: category '#{meta["category"]}' must be one of #{CATEGORIES.join(", ")}"
    next
  end
  report[:no_name] << name if meta["name"].to_s.strip.empty?

  slug   = slugify(name)
  readme = find_readme(dir, meta)
  body   = readme ? File.read(readme, encoding: "bom|utf-8") : ""
  report[:no_readme] << name unless readme
  report[:empty_readme] << name if readme && body.strip.empty?
  body = rewrite_links(body, readme, dir, repo, slug) unless body.strip.empty?

  date = meta["date"]
  date = Date.parse(date.to_s) rescue nil unless date.is_a?(Date)

  front = {
    "title" => meta["name"].to_s.strip.empty? ? name : meta["name"].to_s.strip,
    "category" => category,
    "technology" => meta["technology"].to_s,
    "author" => meta["author"].to_s,
    "date" => date,
    "repo" => name,
    "repo_url" => repo["html_url"],
    "related" => Array(meta["related"]).map { |r| r.to_s.strip }.reject(&:empty?),
    "render_with_liquid" => false
  }.compact
  body = normalize_title(body, "#{front["technology"]}: #{front["title"]}") unless front["technology"].empty?

  File.write(File.join(OUT_DIR, "#{slug}.md"), "#{YAML.dump(front)}---\n\n#{body}")
  report[:published] << name
end

published = report[:published]
Dir.glob(File.join(OUT_DIR, "*.md")).each do |file|
  front = YAML.safe_load(File.read(file)[/\A---\n(.*?)\n---/m, 1], permitted_classes: [Date])
  front.fetch("related", []).reject { |r| published.include?(r) }.each do |r|
    report[:related] << "#{front["repo"]}: related '#{r}' is not a listed example (links to GitHub instead)"
  end
end

puts
puts "Published #{report[:published].size} examples to _examples/"
{
  no_yaml: "Repositories without #{META_FILE} (not listed)",
  no_readme: "Examples without README (page shows placeholder)",
  empty_readme: "Examples with an empty README (page shows placeholder)",
  no_name: "Examples without name (repository name used)",
  related: "Related repositories",
  errors: "Errors (not listed)"
}.each do |key, label|
  next if report[key].empty?

  puts
  puts "#{label}:"
  report[key].each { |line| puts "  - #{line}" }
end
