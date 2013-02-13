# encoding: utf-8

require 'spec_helper'

module Arss
  describe ParseData do
    let(:data) do
      Class.new.extend(ParseData)
    end

    describe 'parse_tags' do
      it 'returns an empty hash if the text does not contain any tags' do
        tags = %w(first_tag second_tag)
        data.parse_tag('channel', tags, "Here's looking at you, kid.").should be_empty
      end

      it 'returns an empty hash if the tags in the text are not needed' do
        text = <<-TEXT
                <channel>
                  <name>Sudden Impact</name>
                  <quote>Go ahead, make my day</quote>
                </channel>
                TEXT
        tags = %w(first_tag second_tag)
        data.parse_tag('channel', tags, text).should be_empty
      end

      it 'successfully extracts all the subtags if present' do
        text = <<-TEXT
        <channel>
          <title>Sunset Boulevard</title>
          <link>http://www.imdb.com/title/tt0043014/</link>
          <description>A hack screenwriter writes a screenplay..</description>
          <language>English</language>
          <rating>8.6</rating>
        </channel>
        TEXT
        tags = %w(title link description language rating)
        data.parse_tag('channel', tags, text).should eq({'title' => 'Sunset Boulevard',
                                                        'link' => 'http://www.imdb.com/title/tt0043014/',
                                                        'description' => 'A hack screenwriter writes a screenplay..',
                                                        'language' => 'English',
                                                        'rating' => '8.6'})
      end

      # http://en.wikipedia.org/wiki/Unix_time#Notable_events_in_Unix_time
      it 'transforms the date tags in unix timestamp format' do
        text = <<-TEXT
                <channel>
                  <pubDate>Fri, 18 Mar 2005 01:58:31 UTC</pubDate>
                  <lastBuildDate>Fri, 13 Feb 2009 23:31:30 UTC</lastBuildDate>
                </channel>
                TEXT
        tags = %w(pubDate lastBuildDate)
        data.parse_tag('channel', tags, text).should eq({'pubDate' => 1111111111,
                                                        'lastBuildDate' => 1234567890})
      end
    end

    describe 'parse_items' do
      it 'returns an empty list if the text does not contain any item tags' do
        data.parse_items("Fasten your seatbelts. It's going to be a bumpy night.").should be_empty
      end

      it 'returs an empty list if the item tags do not have any valid <item> tags' do
        text = <<-TEXT
        <item>
          <quote>You talkin' to me?</quote>
          <name>Taxi Driver</name>
        </item>
        <item>
          <quote>What we've got here is failure to communicate.</quote>
          <name>Cool Hand Luke</name>
        </item>
        TEXT
        data.parse_items(text).should be_empty
      end

      it 'exctracts the valid subtags from the <item> tags' do
        text = <<-TEXT
        <item>
          <title>Apocalypse Now</title>
          <comments>Love means never having to say you're sorry.</comments>
        </item>
        <item>
          <title>Love Story</title>
          <description>Harvard Law student Oliver Barrett IV and music student..</description>
          <category>Drama/Romance</category>
          <author>Erich Segal</author>
        </item>
        TEXT
        data.parse_items(text).should eq [{'title' => 'Apocalypse Now',
                                            'comments' => "Love means never having to say you're sorry."},
                                          {'title' => 'Love Story',
                                            'description' => 'Harvard Law student Oliver Barrett IV and music student..',
                                            'category' => 'Drama/Romance',
                                            'author' => 'Erich Segal'}]
      end
    end
  end
end