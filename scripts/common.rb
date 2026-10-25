# frozen_string_literal: true

# Helpers shared by scripts/update.rb (examples) and scripts/howtos.rb
# (manuals): GitHub access, cloning, and turning a README into a page.

require "yaml"
require "json"
require "net/http"
require "uri"
require "open3"
require "fileutils"
require "base64"

ROOT      = File.expand_path("..", __dir__)
CONFIG    = YAML.safe_load(File.read(File.join(ROOT, "_config.yml")))
ORG       = CONFIG.fetch("github_org")
CACHE_DIR = File.join(ROOT, ".cache", "repos")
IMAGE_EXT = %w[.png .jpg .jpeg .gif .svg .webp .avif].freeze

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

# Repository info of a local clone, in the shape of the GitHub API
def local_repo(dir)
  name   = File.basename(dir)
  remote = (run("git", "-C", dir, "remote", "get-url", "origin").strip rescue "")
  {
    "name" => name,
    "dir" => dir,
    "html_url" => remote.empty? ? "https://github.com/#{ORG}/#{name}" : remote.sub(/\.git\z/, ""),
    "default_branch" => run("git", "-C", dir, "branch", "--show-current").strip
  }
end

def slugify(name)
  name.downcase.gsub(/[^a-z0-9]+/, "-").gsub(/\A-|-\z/, "")
end

# Rewrites relative links in a README: images (and linked files with an
# extension in `copy_ext`) are copied to asset_dir and linked via asset_url,
# everything else points to the file on GitHub.
def rewrite_links(markdown, readme_path, repo_dir, repo, asset_dir, asset_url, copy_ext = [])
  readme_dir = File.dirname(readme_path)
  in_fence = false

  rewrite = lambda do |target, image|
    return target if target.empty? || target.match?(%r{\A(?:[a-z][a-z0-9+.-]*:|#|/)}i)

    path, anchor = target.split("#", 2)
    file = File.expand_path(URI.decode_www_form_component(path.gsub("+", "%2B")), readme_dir)
    return target unless file.start_with?(repo_dir)

    rel = file.delete_prefix("#{repo_dir}/")
    encoded = rel.split("/").map { |p| URI.encode_www_form_component(p).gsub("+", "%20") }.join("/")
    ext = File.extname(file).downcase
    if File.file?(file) && ((image && IMAGE_EXT.include?(ext)) || copy_ext.include?(ext))
      dest = File.join(asset_dir, rel)
      FileUtils.mkdir_p(File.dirname(dest))
      FileUtils.cp(file, dest)
      "#{asset_url}/#{encoded}"
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
