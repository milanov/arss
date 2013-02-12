# encoding: utf-8

require 'arss/data_extract'

module Arss
  module DataParser
    module ImageParser
      extend self

      IMAGE_TAGS = ['title', 'url', 'link', 'width', 'height', 'description']

      # Parses the <image> tag and returns a hash with keys the tags above (image tags)
      # and their values from the rss document, if present. These subtags are the ones
      # allowed by the RSS specification for the <image> tag.
      def parse_image_tag(rss_feed)
        image_text = extract_text_from_tag(rss_feed, 'image')
        image_tags = {}

        IMAGE_TAGS.each do |tag|
          tag_text = DataExtractor.extract_text_from_tag(image_text, tag)
          image_tags[tag] = tag_text unless tag_text.empty?
        end

        image_tags
      end
    end
  end
end
