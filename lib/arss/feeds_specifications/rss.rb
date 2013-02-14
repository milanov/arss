# encoding: utf-8

module Arss
  module RssSpecification
    CHANNEL_TAGS = ['title', 'link', 'description', 'language', 'copyright',
    'managingEditor', 'webMaster', 'pubDate', 'lastBuildDate', 'category',
    'generator', 'cloud', 'ttl', 'skipDays', 'skipHours', 'rating', 'docs'].freeze

    ITEM_TAGS = ['title', 'link', 'description', 'author', 'category',
    'comments', 'enclosure', 'guid', 'pubDate', 'source', 'content:encoded'].freeze

    IMAGE_TAGS = ['title', 'url', 'link', 'width', 'height', 'description'].freeze
    TEXTINPUT_TAGS = ['title', 'description', 'name', 'link'].freeze
  end
end


# EXPERIMENTAL
# FEED_FORMAT = {'channel' => CHANNEL_TAGS + [{'image' => IMAGE_TAGS}]
# + [{'textinput' => TEXTINPUT_TAGS}] + [{'item' => ITEM_TAGS}]}