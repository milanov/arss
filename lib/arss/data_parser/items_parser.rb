# encoding: utf-8

require 'arss/data_extract'
require 'arss/data_transform'

module Arss
  module DataParser
    module ItemsParser
      extend self

      ITEMS_TAGS = ['title', 'link', 'description', 'author', 'category',
      'comments', 'enclosure', 'guid', 'pubDate', 'source', 'content:encoded']

      # Parses all <item> tags from a given rss-formatted text and parses them
      # individually using ItemsParser::parse_single_item.
      # Returns an array of associative arrays with keys being the <item>'s tags
      # and their corresponding values.
      def parse_items(rss_feed)
        items_list = list_same_tag_data(rss_feed, 'item')
        items = []

        items_list.each do |item|
          parsed_item = parse_single_item(item)
          items << parsed_item unless parsed_item.empty?
        end

        items
      end

      private
      # Parses the <item> tag and returns a hash with keys the tags above (image tags)
      # and their values from the rss document, if present. These subtags are the ones
      # allowed by the RSS specification for the <image> tag.
      def parse_single_item(item)
        item_tags = {}

        ITEMS_TAGS.each do |tag|
          tag_text = extract_text_from_tag(item, tag)
          next if tag_text.empty?
          item_tags[tag] = transform_htmlily_tag(tag_text)
          item_tags[tag] = transform_date(tag_text) if tag_text == 'pubDate'
        end

        item_tags
      end
    end
  end
end
