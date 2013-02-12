# encoding: utf-8

require 'arss/data_extract'

module Arss
  module DataParser
    module TextinputParser
      extend self

      TEXTINPUT_TAGS = ['title', 'description', 'name', 'link']

      # Parses the <textinput> tag and returns a hash with keys the tags above (textinput tags)
      # and their values from the rss document, if present. These subtags are the ones allowed by
      # the RSS specification for the <textinput> tag.
      def parse_textinput_tag(rss_feed)
        textinput_text = extract_text_from_tag(rss_feed, 'textinput')
        textinput_tags = {}

        TEXTINPUT_TAGS.each do |tag|
          tag_text = extract_text_from_tag(textinput_text, tag)
          textinput_tags[tag] = tag_text unless tag_text.empty?
        end

        textinput_tags
      end
    end
  end
end