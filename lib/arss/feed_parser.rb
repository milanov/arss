# encoding: utf-8

module Arss
  class FeedParser
    attr_accessor :feed

    # initializes the class with the already parsed rss attributes
    def initialize(channel_tags, textinput_tags, image_tags, items)
      @feed = {}
      @feed['channel'] = channel_tags
      @feed['channel']['textinput'] = textinput_tags unless textinput_tags.empty?
      @feed['channel']['image'] = image_tags unless image_tags.empty?
      @feed['channel']['items'] = items unless items.empty?
    end

    class << self
      # Parse an rss feed. It removes the comments from the feed first, encodes the data
      # in all of the cdata tags so the parser doesn't get confused and then extract the
      # channel text, parsing its subtags, as well as all the items.
      def parse(feed)
        feed = TransformData.encode_data_in_cdata_tags(RemoveData.remove_comments(feed))
        channel_tags = ParseData.parse_tag('channel', RssSpecification::CHANNEL_TAGS, feed)
        textinput_tags = ParseData.parse_tag('textinput', RssSpecification::TEXTINPUT_TAGS, feed)
        image_tags = ParseData.parse_tag('image', RssSpecification::IMAGE_TAGS, feed)
        items = ParseData.parse_items feed
        FeedParser.new channel_tags, textinput_tags, image_tags, items
      end

      # Extracts the content of the given url, changes the encoding to UTF-8
      # and tries to parse it using the FeedParser::parse method.
      def parse_uri(resource)
        feed = ExtractData.extract_contents_from_url(resource).force_encoding 'UTF-8'
        parse feed
      end
    end
  end
end