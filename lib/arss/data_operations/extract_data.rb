# encoding: utf-8

require 'open-uri'

module Arss
  module ExtractData
    extend self

    # Extracts and returns the contents of a given url.
    # Returns an empty string if the url is invalid, there is no such file or directory,
    # there is no connection, and etc.
    def extract_contents_from_url(url)
      begin
        feed = open(url)
        feed.read
      rescue
        ''
      end
    end

    # Returns the text between a given tag in a document, otherwise an
    # empty string.
    def extract_tag_text(text, tag)
      text =~ /<#{tag}( [^\/]+)*>(?<tag_text>.*?)<\/#{tag}>/m ? $~[:tag_text] : ''
    end

    # Returns the text between a given tag in a document, but only if the tag a level 1 tag, e.g.
    # it is not enclosed in another tag.
    #
    # === Example:
    #   extract_subtag_text('<xml><tag>text</tag></xml>', 'xml')
    #   # => '<tag>text</tag>'
    #
    #   extract_subtag_text('<xml><tag>text</tag></xml>', 'tag')
    #   # => ''

    # TODO HERE -> WARNING
    def extract_subtag_text(text, subtag)
      if text =~ /(?<tag><#{subtag}( [^ \/>]+)*?>(?<tag_text>.*?)<\/#{subtag}>)/m
        tag, tag_text =  $~[:tag], $~[:tag_text]

        unless text =~ /<(?<tag>[\w:]+)( [^ \/>]+)*?>(?<anything>.*?)#{Regexp.escape(tag)}\g<anything><\/\k<tag>>/m
          return tag_text
        end
      end
      ''
    end

    # Returns an array in which each element is the data between the given tag.
    #
    # === Example:
    #   list_same_tag_data('<li>1</li><li>2</li><li>3</li>', 'li')
    #   # => ['1', '2', '3']
    def list_same_tag_data(text, tag)
      text.scan(/<#{tag}( [^ \/>]+)*?>(?<tag_text>.*?)<\/#{tag}>/m).map(&:first)
    end
  end
end