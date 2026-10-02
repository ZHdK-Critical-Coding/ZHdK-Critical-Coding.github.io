#!/usr/bin/env ruby
# frozen_string_literal: true

# Collects the literature from Zotero and turns it into _data/literature.json.
#
# Source: all top-level items in the collection set in _config.yml
# (literature.collection, e.g. "Critical Coding/Export"), searched in the
# personal library of the API key and in all groups it can read.
#
# Tags:
#   01_Black-Box_Theorie   topic (two digits + underscore): one page per topic,
#                          listed in the Literature menu
#   Black-Box-Theorie      the same name written out: not repeated as an entry
#                          tag, used as the title of new topic pages
#   everything else        entry tags, shown in the table and used as filters
#
# For every new topic a page literature/<slug>.md is created with a
# placeholder intro; existing pages are never overwritten, so their intro
# and title (shown in the menu) can be edited.
#
# Only bibliographic data is written (authors, title, year, type, tags, link) –
# no API key, library id or Zotero URLs end up on the public site.
#
# Usage:
#   ZOTERO_API_KEY=… bundle exec ruby scripts/literature.rb
#   (or put the key into .zotero_api_key – the file is git-ignored)

require "yaml"
require "json"
require "net/http"
require "uri"
require "fileutils"

ROOT      = File.expand_path("..", __dir__)
CONFIG    = YAML.safe_load(File.read(File.join(ROOT, "_config.yml")))
SETTINGS  = CONFIG.fetch("literature")
COLL_PATH = SETTINGS.fetch("collection").split("/").map(&:strip)
DATA_FILE = File.join(ROOT, "_data", "literature.json")
PAGE_DIR  = File.join(ROOT, "literature")
KEY_FILE  = File.join(ROOT, ".zotero_api_key")
API       = ENV.fetch("ZOTERO_API_URL", "https://api.zotero.org") # override only for tests
TOPIC_TAG = /\A\d{2}_/
SKIP_TYPES = %w[note attachment annotation].freeze
# Zotero item types shown as Book / Article; everything else counts as Web
BOOK_TYPES    = %w[book bookSection thesis report].freeze
ARTICLE_TYPES = %w[journalArticle magazineArticle newspaperArticle conferencePaper
                   encyclopediaArticle dictionaryEntry].freeze

# ---------------------------------------------------------------- helpers

def api_key
  key = ENV["ZOTERO_API_KEY"].to_s.strip
  key = File.read(KEY_FILE).strip if key.empty? && File.file?(KEY_FILE)
  abort "No Zotero API key: set ZOTERO_API_KEY or create .zotero_api_key" if key.empty?
  key
end

def get(path, key, params = {})
  uri = URI("#{API}#{path}")
  uri.query = URI.encode_www_form(params) unless params.empty?
  req = Net::HTTP::Get.new(uri)
  req["Zotero-API-Key"] = key
  req["Zotero-API-Version"] = "3"
  res = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") { |http| http.request(req) }
  # Zotero repeats the key in some error messages – never print it
  abort "Zotero API #{path}: #{res.code} #{res.body.to_s[0, 200].gsub(key, "***")}" unless res.is_a?(Net::HTTPSuccess)
  res
end

# All pages of a list endpoint
def get_all(path, key, params = {})
  results = []
  start = 0
  loop do
    res = get(path, key, params.merge(limit: 100, start: start))
    batch = JSON.parse(res.body)
    results.concat(batch)
    start += batch.size
    break if batch.empty? || start >= res["Total-Results"].to_i
  end
  results
end

# Personal library first, then the groups the key can read
def libraries(key)
  me = JSON.parse(get("/keys/current", key).body)
  libs = []
  libs << "/users/#{me["userID"]}" if me.dig("access", "user", "library")
  get_all("/users/#{me["userID"]}/groups", key).each { |g| libs << "/groups/#{g["id"]}" }
  libs
end

# Follows the collection path ("Critical Coding" > "Export") in one library
def find_collection(lib, key)
  collections = get_all("#{lib}/collections", key)
  parent = false
  found = nil
  COLL_PATH.each do |name|
    found = collections.find do |c|
      c.dig("data", "name").to_s.strip.casecmp?(name) && c.dig("data", "parentCollection") == parent
    end
    return nil unless found

    parent = found["key"]
  end
  found["key"]
end

def creator_name(c)
  c["name"] || [c["lastName"], c["firstName"]].compact.reject(&:empty?).join(", ")
end

# Authors; editors (marked "(Ed.)") if there are no authors
def authors(data)
  creators = data.fetch("creators", [])
  list = creators.select { |c| c["creatorType"] == "author" }
  suffix = ""
  if list.empty?
    list = creators.select { |c| c["creatorType"] == "editor" }
    suffix = list.empty? ? "" : " (Ed.)"
    list = creators if list.empty?
  end
  names = list.map { |c| creator_name(c) }.reject(&:empty?)
  sort = list.first ? (list.first["lastName"] || list.first["name"]).to_s : ""
  [names.join("; ") + (names.empty? ? "" : suffix), sort]
end

def year(item)
  (item.dig("meta", "parsedDate") || item.dig("data", "date")).to_s[/\d{4}/].to_s
end

def link(data)
  return data["url"] if data["url"].to_s.start_with?("http")
  return "https://doi.org/#{data["DOI"]}" unless data["DOI"].to_s.empty?

  nil
end

def kind(item_type)
  return "book" if BOOK_TYPES.include?(item_type)
  return "article" if ARTICLE_TYPES.include?(item_type)

  "web"
end

def topic_title(tag)
  tag.sub(TOPIC_TAG, "").tr("_", " ").strip
end

def slugify(s)
  s.downcase.gsub(/[äöü]/, "ä" => "ae", "ö" => "oe", "ü" => "ue").gsub(/[^a-z0-9]+/, "-").gsub(/\A-|-\z/, "")
end

# Compares tag names without number, case, punctuation and umlaut spelling:
# "04_Medientheorie_Aesthetik" ~ "Medientheorie & Ästhetik"
def tag_key(tag)
  tag.sub(TOPIC_TAG, "").downcase
     .gsub(/[äöüß]/, "ä" => "ae", "ö" => "oe", "ü" => "ue", "ß" => "ss")
     .gsub(/[^a-z0-9]/, "")
end

# An entry tag that repeats a topic: the same name, or the topic name
# continued ("Interface, HCI & Disappearing Computer" for 05_Interface_HCI_Disappearing)
def repeats_topic?(tag, topic_keys)
  key = tag_key(tag)
  topic_keys.any? { |t| !t.empty? && key.start_with?(t) }
end

def sort_tags(tags)
  tags.uniq.sort_by(&:downcase)
end

# ---------------------------------------------------------------- main

key = api_key
lib, coll = nil
libraries(key).each do |l|
  coll = find_collection(l, key)
  if coll
    lib = l
    break
  end
end
abort "Collection #{COLL_PATH.join(" > ")} not found in any library of this key" unless coll

raw = get_all("#{lib}/collections/#{coll}/items/top", key, format: "json")
raw.reject! { |i| SKIP_TYPES.include?(i.dig("data", "itemType")) }
item_tags = ->(i) { i.dig("data", "tags").to_a.map { |t| t["tag"].to_s.strip }.reject(&:empty?) }

# Topic tags and the written-out names that repeat them
topic_keys = raw.flat_map { |i| item_tags.(i).grep(TOPIC_TAG) }.uniq.to_h { |t| [t, tag_key(t)] }
repeats = Hash.new { |h, k| h[k] = [] }
raw.each do |i|
  item_tags.(i).grep_v(TOPIC_TAG).each do |t|
    topic_keys.each { |topic, k| repeats[topic] << t if repeats_topic?(t, [k]) }
  end
end

items = raw.map do |i|
  d = i["data"]
  tags = item_tags.(i).reject { |t| !t.match?(TOPIC_TAG) && repeats_topic?(t, topic_keys.values) }
  author, author_sort = authors(d)
  {
    "author" => author,
    "author_sort" => author_sort,
    "title" => d["title"].to_s.strip,
    "year" => year(i),
    "type" => kind(d["itemType"]),
    "url" => link(d),
    "topics" => sort_tags(tags.grep(TOPIC_TAG)),
    "tags" => sort_tags(tags.grep_v(TOPIC_TAG))
  }.compact
end
items.sort_by! { |i| [i["author_sort"].downcase, i["year"], i["title"].downcase] }

topics = items.flat_map { |i| i["topics"] }.uniq.sort.map do |tag|
  in_topic = items.select { |i| i["topics"].include?(tag) }
  # the most used written-out name, else the tag without number and underscores
  written = repeats[tag].tally.max_by { |name, n| [n, -name.length] }&.first
  {
    "tag" => tag,
    "title" => written || topic_title(tag),
    "slug" => slugify(topic_title(tag)),
    "count" => in_topic.size,
    "tags" => sort_tags(in_topic.flat_map { |i| i["tags"] })
  }
end

FileUtils.mkdir_p(File.dirname(DATA_FILE))
File.write(DATA_FILE, JSON.pretty_generate(
  "topics" => topics,
  "tags" => sort_tags(items.flat_map { |i| i["tags"] }),
  "items" => items
) + "\n")

# A page per topic, created once with a placeholder intro
FileUtils.mkdir_p(PAGE_DIR)
created = []
topics.each do |t|
  file = File.join(PAGE_DIR, "#{t["slug"]}.md")
  next if File.exist?(file)

  File.write(file, <<~MD)
    ---
    layout: literature
    topic: "#{t["tag"]}"
    title: "#{t["title"]}"
    permalink: /literature/#{t["slug"]}/
    ---

    <div class="lang" lang="en" markdown="1">

    #{t["title"]}

    </div>

    <div class="lang" lang="de" markdown="1">

    #{t["title"]}

    </div>
  MD
  created << file.delete_prefix("#{ROOT}/")
end

known = topics.map { |t| "#{t["slug"]}.md" } + ["index.md"]
stale = Dir.children(PAGE_DIR).grep(/\.md\z/) - known

puts "#{items.size} entries, #{topics.size} topics from #{COLL_PATH.join(" > ")} -> _data/literature.json"
created.each { |f| puts "  created #{f} (edit its intro)" }
stale.each { |f| puts "  literature/#{f} has no topic in Zotero any more – delete it?" }
no_topic = items.count { |i| i["topics"].empty? }
puts "  #{no_topic} entries without a topic tag (only on the overview page)" if no_topic.positive?
