# encoding: utf-8

require 'htmlentities'

module Arss
  module DataTransform
    extend self

    # Encodes the data in all of the cdata tags using htmlentities encode, so that the parser works
    # correctly even  if there are valid unencoded rss/xml tags present in the cdata tags.
    #
    # === Example:
    #   encode_cdata_data('<xml><data><![CDATA[</xml></data>]]></data></xml>')
    #   # => <xml><data><![CDATA[&lt;/xml&gt;&lt;/data&gt;]]></data></xml>
    def encode_data_in_cdata_tags(rss_text)
      rss_text.gsub /<!\[CDATA\[(?<element_text>.*?)\]\]>/m do
        '<![CDATA[' + HTMLEntities.new.encode($~[:element_text]) + ']]>'
      end
    end

    # A very OPINIONATED method. It is used to "clean up" the data that is in
    # the <item> tags in a rss document. It removes the enclosing cdata tag
    # if present, decodes the html in case it is encoded and then removes it,
    # leaving only the plain text (stripping any whitespace).
    def transform_htmlily_tag(item_tag)
      decoded_tag = HTMLEntities.new.decode DataRemoval.remove_cdata(item_tag)
      plain_text = DataRemoval.remove_html_tags decoded_tag
      plain_text.gsub /\s+/, ' '
    end

    # Transforms a given date from a RFC 822 format to a unix
    # timestamp, a.k.a. the seconds elapsed since midnight UTC, 1st
    # January 1970.
    def transform_date(date)
      begin
        Time.parse(date).to_i
      rescue
        ''
      end
    end
  end
end