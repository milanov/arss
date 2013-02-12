# encoding: utf-8

require 'spec_helper'

module Arss
  module DataParser
    describe ChannelParser do
      let(:data) do
        Class.new.extend(ChannelParser)
      end

      describe 'parse_channel_tag' do
        it 'returns an empty hash if the text does not contain any tags' do
          data.parse_channel_tag("Here's looking at you, kid.").should be_empty
        end

        it 'returns an empty hash if the tags in the text are not valid' do
          text = <<-TEXT
                  <channel>
                    <name>Sudden Impact</name>
                    <quote>Go ahead, make my day</quote>
                  </channel>
                  TEXT
          data.parse_channel_tag(text).should be_empty
        end

        # http://en.wikipedia.org/wiki/Unix_time#Notable_events_in_Unix_time
        it 'transforms the dates in unix timestamp format' do
          text = <<-TEXT
                  <channel>
                    <pubDate>Fri, 18 Mar 2005 01:58:31 UTC</pubDate>
                    <lastBuildDate>Fri, 13 Feb 2009 23:31:30 UTC</lastBuildDate>
                  </channel>
                  TEXT
          data.parse_channel_tag(text).should eq({'pubDate' => 1111111111,
                                                  'lastBuildDate' => 1234567890})
        end

        it 'successfully extracts (example part of) the channel tags according to specification' do
          text = <<-TEXT
          <channel>
            <title>Sunset Boulevard</title>
            <link>http://www.imdb.com/title/tt0043014/</link>
            <description>A hack screenwriter writes a screenplay..</description>
            <language>English</language>
            <rating>8.6</rating>
          </channel>
          TEXT
          data.parse_channel_tag(text).should eq({'title' => 'Sunset Boulevard',
                                                  'link' => 'http://www.imdb.com/title/tt0043014/',
                                                  'description' => 'A hack screenwriter writes a screenplay..',
                                                  'language' => 'English',
                                                  'rating' => '8.6'})
        end
      end
    end
  end
end