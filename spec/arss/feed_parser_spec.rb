# encoding: utf-8

require 'spec_helper'

module Arss
  describe FeedParser do
    describe 'parse' do
      it 'returns an empty hash if the feed is not valid' do
        FeedParser.parse('I see dead people.').feed.should be_empty
      end

      # serves mainly as an example of how to use the parser and what it returns
      it 'parses a given rss feed correctly according to the RSS 2.0 specification' do
        feed = <<-FEED
        <rss>
          <channel>
            <title>Pedro Almodovar</title>
            <description>A list of some of Almodovar's best movies.</description>
            <image>
              <width>2</width>
              <height>2</height>
            </image>
            <item>
              <title>La piel que habito</title>
              <description>A brilliant plastic surgeon, haunted by past tragedies..</description>
            </item>
            <item>
              <title>Hable con ella</title>
              <description>Two men share an odd friendship while they care for..</description>
            </item>
          </channel>
        </rss>
        FEED
        FeedParser.parse(feed).feed.should eq({'channel' =>
                                                    {'title' => 'Pedro Almodovar',
                                                    'description' => "A list of some of Almodovar's best movies.",
                                                    'image' =>
                                                        {'width' => '2', 'height' => '2'},
                                                    'items' =>
                                                        [{'title' => 'La piel que habito',
                                                          'description' => 'A brilliant plastic surgeon, haunted by past tragedies..'},
                                                        {'title' => 'Hable con ella',
                                                          'description' => 'Two men share an odd friendship while they care for..'}]}})


      end
    end

    describe 'parse_uri' do
      it 'returns an empty feed if the url(or file resource) is not reachable or does not exist' do
        FeedParser.parse_uri('fake/feed.rss').feed.should be_empty
      end

      it 'parses the feed if the url(or file resource) is valid and exists' do
        url = File.join(File.dirname(__FILE__), 'resources/feed.rss')
        FeedParser.parse_uri(url).feed.should eq({'channel' =>
                                                      {'title' => 'Cool Hand Luke',
                                                      'language' => 'English'}})
      end
    end
  end
end