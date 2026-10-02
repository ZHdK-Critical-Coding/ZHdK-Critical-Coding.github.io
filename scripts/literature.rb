#!/usr/bin/env ruby
# frozen_string_literal: true

# Collects the literature from Zotero and turns it into _data/literature.json.
#
# Source: all top-level items in the collection set in _config.yml
# (literature.collection, e.g. "Critical Coding/Export"), searched in the
# personal library of the API key and in all groups it can read.
#
# Tags:
#   02_Medientheorie       category (two digits + underscore): Category column,
#                          ordered by number. Its name comes from
#                          literature.categories in _config.yml, which this
#                          script rewrites on every run (see write_categories)
#   everything else        entry tags, shown in the table and used as filters
#
# Only bibliographic data is written (authors, title, year, type, category, tags, link) –
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
CONFIG_FILE = File.join(ROOT, "_config.yml")
CAT_NAMES = SETTINGS.fetch("categories", nil) || {}   # "02_Medientheorie" => "Medientheorie"
DATA_FILE = File.join(ROOT, "_data", "literature.json")
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

# Rewrites the block "  categories:" under "literature:" in _config.yml with
# the current categories; the rest of the file (and its comments) stays as is.
def write_categories(names)
  lines = File.readlines(CONFIG_FILE)
  start = lines.index { |l| l.match?(/\A  categories:\s*\z/) } or abort "_config.yml: no '  categories:' under literature:"
  stop = start + 1
  stop += 1 while stop < lines.size && lines[stop].match?(/\A    \S/)
  block = names.map { |tag, name| "    #{tag}: #{name.to_json}\n" }
  File.write(CONFIG_FILE, (lines[0..start] + block + lines[stop..]).join)
end

def topic_title(tag)
  tag.sub(TOPIC_TAG, "").tr("_", " ").strip
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

items = raw.map do |i|
  d = i["data"]
  tags = d.fetch("tags", []).map { |t| t["tag"].to_s.strip }.reject(&:empty?)
  author, author_sort = authors(d)
  {
    "author" => author,
    "author_sort" => author_sort,
    "title" => d["title"].to_s.strip,
    "year" => year(i),
    "type" => kind(d["itemType"]),
    "url" => link(d),
    "topics" => tags.grep(TOPIC_TAG).sort,
    "tags" => sort_tags(tags.grep_v(TOPIC_TAG))
  }.compact
end
items.sort_by! { |i| [i["author_sort"].downcase, i["year"], i["title"].downcase] }

# Category names from _config.yml, else the tag without number and underscores
categories = items.flat_map { |i| i["topics"] }.uniq.sort
# names you set in _config.yml are kept, new categories get one derived from the tag
names = categories.to_h { |t| [t, CAT_NAMES[t].is_a?(String) ? CAT_NAMES[t] : topic_title(t)] }
added = categories.reject { |t| CAT_NAMES[t].is_a?(String) }
removed = CAT_NAMES.keys - categories

items.each do |i|
  topics = i.delete("topics")
  i["categories"] = topics.map { |t| names[t] }
  i["category_sort"] = topics.join(" ")  # sorts by number
end

FileUtils.mkdir_p(File.dirname(DATA_FILE))
# Filter row: only tags used by two or more entries (single-use tags stay
# visible on their entry and still work as filters there)
tag_count = items.flat_map { |i| i["tags"] }.tally
File.write(DATA_FILE, JSON.pretty_generate(
  "tags" => sort_tags(tag_count.select { |_, n| n > 1 }.keys),
  "categories" => categories.map { |t| names[t] },  # category filter row
  "items" => items
) + "\n")

puts "#{items.size} entries, #{categories.size} categories from #{COLL_PATH.join(" > ")} -> _data/literature.json"
write_categories(names)
added.each { |t| puts "  new category #{t} -> \"#{names[t]}\" (name can be changed in _config.yml)" }
removed.each { |t| puts "  category #{t} is no longer used – removed from _config.yml" }
no_category = items.count { |i| i["categories"].empty? }
puts "  #{no_category} entries without a category tag" if no_category.positive?
