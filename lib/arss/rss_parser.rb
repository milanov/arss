# encoding: utf-8

module Arss
  class RssParser
    attr_accessor :feed

    # initializes the class with the already parsed rss attributes
    def initialize(channel_tags, textinput_tags, image_tags, items)
      @feed = {}
      @feed['channel'] = channel_tags unless channel_tags.empty?
      @feed['channel']['textinput'] = textinput_tags unless textinput_tags.empty?
      @feed['channel']['image'] = image_tags unless image_tags.empty?
      @feed['channel']['items'] = items unless items.empty?
    end

    class << self
      # Parse an rss feed. RSS::Parser removes the comments from the feed first, encodes the data
      # in all of the cdata tags so the parser doesn't get confused and then parses the channel,
      # textinput and image tags elements, as well as all the items. Returns an RssParser instance
      # with all the parsed elements as instance data.
      def parse(rss_feed)
        rss_feed = DataRemoval.remove_comments(rss_feed)
        rss_feed = DataTransform.encode_data_in_cdata_tags(rss_feed)
        channel_tags = DataParser::ChannelParser.parse_channel_tag rss_feed
        textinput_tags = DataParser::TextinputParser.parse_textinput_tag rss_feed
        image_tags = DataParser::ImageParser.parse_image_tag rss_feed
        items = DataParser::ItemsParser.parse_items rss_feed
        RssParser.new channel_tags, textinput_tags, image_tags, items
      end

      # Extracts the content of the given url, changes the encoding to UTF-8
      # and tries to parse it using the RssParser::parse method.
      def parse_uri(rss_uri)
        rss_feed = DataExtract.extract_contents_from_url rss_uri
        rss_feed.force_encoding 'UTF-8'
        parse rss_feed
      end
    end
  end
end