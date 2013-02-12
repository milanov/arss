# encoding: utf-8

module Arss
  module DataRemoval
    extend self

    # Removes all html/xml-style comments from a given text.
    def remove_comments(rss_text)
      rss_text.gsub /<!--(.*?)-->/m, ''
    end

    # Removes every cdata tag it can find but leaves the contents of these tags.
    def remove_cdata(element)
      element.gsub /<!\[CDATA\[(?<element_text>.*?)\]\]>/m, '\k<element_text>'
    end

    # Strips html tags, including their attributes, but leaves the
    # contents of these tags.
    def remove_html_tags(text)
       text.gsub /<[^<]*?\/?>/m, ''
    end
  end
end