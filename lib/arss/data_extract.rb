# encoding: utf-8

require 'open-uri'

module Arss
  module DataExtract
    extend self

    # Extracts and returns the contents of a given url.
    # Returns an empty string if the url is invalid, there is no such file or directory,
    # there is no connection, and etc.
    def extract_contents_from_url(rss_url)
      begin
        feed = open(rss_url)
        feed.read
      rescue => error
        ''
      end
    end

    # Returns the text between a given tag from a rss document, otherwise an
    # empty string.
    def extract_text_from_tag(rss_text, tag)
      rss_text =~ /<#{tag}.*?>(?<tag_text>.*?)<\/#{tag}>/m ? $~[:tag_text] : ''
    end

    # Returns an array in which each element is the data between the given tag.
    #
    # === Example:
    #   list_same_tag_data('<li>1</li><li>2</li><li>3</li>', 'li')
    #   # => ['1', '2', '3']
    def list_same_tag_data(rss_text, tag)
      tag_data = rss_text.scan(/<#{tag}.*?>(?<tag_text>.*?)<\/#{tag}>/m).map(&:first)
    end
  end
end