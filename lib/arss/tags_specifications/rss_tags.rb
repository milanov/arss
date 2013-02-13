# encoding: utf-8

module Arss
  module RssTags
    CHANNEL_TAGS = ['title', 'link', 'description', 'language', 'copyright',
    'managingEditor', 'webMaster', 'pubDate', 'lastBuildDate', 'category',
    'generator', 'cloud', 'ttl', 'skipDays', 'skipHours', 'rating', 'docs'].freeze

    ITEMS_TAGS = ['title', 'link', 'description', 'author', 'category',
    'comments', 'enclosure', 'guid', 'pubDate', 'source', 'content:encoded'].freeze

    IMAGE_TAGS = ['title', 'url', 'link', 'width', 'height', 'description'].freeze
    TEXTINPUT_TAGS = ['title', 'description', 'name', 'link'].freeze
  end
end