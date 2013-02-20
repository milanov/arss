# encoding: utf-8

module Arss
  module ParseData
    extend self

    # Exctracts all <item> tags from a given document and parses them
    # individually using DataParser::extract_tags.
    # Returns an array of associative arrays with keys being the <item>'s tags
    # and their corresponding values.
    def parse_items(feed)
      items = ExtractData.list_same_tag_data(feed, 'item').map { |item| "<item>#{item}</item>"}
      parsed_items = []

      items.each do |item|
        parsed_item = parse_tag('item', RssSpecification::ITEM_TAGS, item)
        parsed_items << parsed_item unless parsed_item.empty?
      end

      parsed_items
    end

    # Parses the given 'feed' text by extracting the 'tag' data from it and then trying to
    # parse this tag's subtags.
    # This method is used to extract the subtags from the channel, items, image and textinput
    # tags in a given feed.
    def parse_tag(tag, subtags, feed)
      extracted_subtags = {}
      feed = ExtractData.extract_tag_text(feed, tag)

      subtags.each do |sub|
        sub_text = ExtractData.extract_subtag_text(feed, sub)
        extracted_subtags[sub] = TransformData.tag_to_plaintext(sub_text) unless sub_text.empty?
      end

      transform_dates_in extracted_subtags
    end

    # Takes a hash and transforms each date to a unix timestamp. Dates are the records in the
    # hash which have a key that is either pubDate or lastBuildDate.
    def transform_dates_in(tags)
      datetime_tags = %w(pubDate lastBuildDate)
      tags.each do |tagname, value|
        if datetime_tags.include?(tagname)
          tags[tagname] = TransformData.datetag_to_timestamp(value)
        end
      end
    end
  end
end