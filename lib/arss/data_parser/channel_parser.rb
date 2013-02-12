# encoding: utf-8

require 'arss/data_extract'
require 'arss/data_transform'

module Arss
  module DataParser
    module ChannelParser
      extend self

      CHANNEL_TAGS = ['title', 'link', 'description', 'language', 'copyright',
      'managingEditor', 'webMaster', 'pubDate', 'lastBuildDate', 'category',
      'generator', 'cloud', 'ttl', 'skipDays', 'skipHours', 'rating', 'docs']

      # Parses the <channel> tag and returns a hash with keys the tags above (channel tags)
      # and their values from the rss document if present. These tags are the ones allowed
      # by the RSS specification. It also transofrms the pubDate/lastBuildDate tags
      # from a text-formatted date to a unix timestamp.
      def parse_channel_tag(rss_feed)
        channel_text = extract_text_from_tag rss_feed, 'channel'
        channel_tags = {}

        CHANNEL_TAGS.each do |tag|
          tag_text = extract_text_from_tag(channel_text, tag)
          next if tag_text.empty?
          channel_tags[tag] = case tag
                              when 'pubDate', 'lastBuildDate' then transform_date(tag_text)
                              else tag_text
                              end
        end

        channel_tags
      end
    end
  end
end