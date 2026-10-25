#!/usr/bin/env ruby
# frozen_string_literal: true

# Collects the manuals of the Manuals repository (`howtos_repo` in
# _config.yml) and turns them into the Jekyll collection `_howtos`.
#
# `howtos.yaml` in the root of that repository lists the manuals; every entry
# is one page and one entry in the How-To's menu, in this order:
#
#   howtos:
#     - folder: Terminal          # folder of the manual
#       title: Terminal           # menu entry and page title
#       title_de: Terminal        # optional, German title (default: title)
#       readme: Terminal/Mac.md   # optional, default: README.md in the folder
#
# Without a README the page lists the files of the folder (e.g. PDFs).
# Images and PDFs linked from a manual are copied into assets/howtos/.
#
# Usage:
#   bundle exec ruby scripts/howtos.rb                    # shallow-clone the repo from GitHub
#   bundle exec ruby scripts/howtos.rb --local ../Manuals # use an existing local clone instead

require "optparse"
require_relative "common"

REPO_NAME  = CONFIG.fetch("howtos_repo")
META_FILE  = "howtos.yaml"
OUT_DIR    = File.join(ROOT, "_howtos")
ASSET_DIR  = File.join(ROOT, "assets", "howtos")
ASSET_URL  = "../../assets/howtos"
COPY_EXT   = %w[.pdf].freeze

options = {}
OptionParser.new do |o|
  o.banner = "Usage: ruby scripts/howtos.rb [--local DIR]"
  o.on("--local DIR", "Read the manuals from a local clone in DIR") { |d| options[:local] = File.expand_path(d) }
end.parse!

if options[:local]
  repo = local_repo(options[:local])
  dir  = repo["dir"]
else
  token = github_token
  res = api_get("/repos/#{ORG}/#{REPO_NAME}", token)
  abort "GitHub API: #{res.code} #{res.body}" unless res.is_a?(Net::HTTPSuccess)
  repo = JSON.parse(res.body)
  print "  pulling #{REPO_NAME} … "
  dir = sync_repo(repo, token)
  puts "ok"
end

meta_path = File.join(dir, META_FILE)
abort "#{REPO_NAME}: no #{META_FILE}" unless File.file?(meta_path)
entries = Array((YAML.safe_load(File.read(meta_path)) || {})["howtos"])

FileUtils.rm_rf(OUT_DIR)
FileUtils.rm_rf(ASSET_DIR)
FileUtils.mkdir_p(OUT_DIR)

report = Hash.new { |h, k| h[k] = [] }

entries.each_with_index do |entry, index|
  folder = entry["folder"].to_s.strip
  folder_dir = File.join(dir, folder)
  unless !folder.empty? && File.directory?(folder_dir)
    report[:errors] << "folder '#{folder}' does not exist"
    next
  end

  readme =
    if entry["readme"]
      File.join(dir, entry["readme"])
    else
      file = Dir.children(folder_dir).find { |f| f.casecmp?("readme.md") }
      file && File.join(folder_dir, file)
    end
  if readme && !File.file?(readme)
    report[:errors] << "#{folder}: readme '#{entry["readme"]}' does not exist"
    next
  end

  if readme
    body = File.read(readme, encoding: "bom|utf-8")
  else
    # no README: list the files of the folder
    readme = File.join(folder_dir, "README.md")
    files  = Dir.children(folder_dir).reject { |f| f.start_with?(".") }.sort_by(&:downcase)
    body   = files.map { |f| "- [#{f}](<#{f}>)" }.join("\n")
    report[:no_readme] << folder
  end
  body = rewrite_links(body, readme, dir, repo, ASSET_DIR, ASSET_URL, COPY_EXT)

  title = entry["title"].to_s.strip
  title = folder if title.empty?
  front = {
    "title" => title,
    "title_de" => entry["title_de"].to_s.strip.empty? ? title : entry["title_de"].to_s.strip,
    "order" => index + 1,
    "folder" => folder,
    "repo_url" => "#{repo["html_url"]}/tree/#{repo["default_branch"]}/#{folder.split("/").map { |p| URI.encode_www_form_component(p).gsub("+", "%20") }.join("/")}",
    "render_with_liquid" => false
  }.compact

  File.write(File.join(OUT_DIR, "#{slugify(folder)}.md"), "#{YAML.dump(front)}---\n\n#{body.strip}\n")
  report[:published] << folder
end

listed = entries.map { |e| e["folder"].to_s.strip.split("/").first }
report[:unlisted] = Dir.children(dir).select { |f| File.directory?(File.join(dir, f)) && !f.start_with?(".") } - listed

puts
puts "Published #{report[:published].size} how-to's to _howtos/"
{
  no_readme: "Manuals without README (page lists the files)",
  unlisted: "Folders not listed in #{META_FILE}",
  errors: "Errors (not listed)"
}.each do |key, label|
  next if report[key].empty?

  puts
  puts "#{label}:"
  report[key].each { |line| puts "  - #{line}" }
end
