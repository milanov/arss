# encoding: utf-8

require 'spec_helper'

module Arss
  describe DataTransform do
    let(:data) do
      Class.new.extend(DataTransform)
    end

    describe 'encode_data_in_cdata_tags' do
      it 'does not encode anything unless in wrapped cdata tag' do
        data.encode_data_in_cdata_tags('simple text').should eq 'simple text'
      end

      it 'does not encode non-entites in a cdata tag' do
        text = '<![CDATA[simple text]]>'
        data.encode_data_in_cdata_tags(text).should eq text
      end

      it 'encodes entities is multiple cdata tags' do
        text = <<TEXT
<![CDATA[lower: <]]>
<![CDATA[greater: >]]>
TEXT
        expected = <<TEXT
<![CDATA[lower: &lt;]]>
<![CDATA[greater: &gt;]]>
TEXT
        data.encode_data_in_cdata_tags(text).should eq expected
      end

      it 'encodes entities only wrapped in cdata tag' do
        text = '<movie name="Less Than Zero"><![CDATA[< than 0]]></movie>'
        expected = '<movie name="Less Than Zero"><![CDATA[&lt; than 0]]></movie>'
        data.encode_data_in_cdata_tags(text).should eq expected
      end
    end

    describe 'transform_htmlily_tag' do
      it 'removes cdata tags from the text' do
        data.transform_htmlily_tag('<![CDATA[simple text]]>').should eq 'simple text'
      end

      it 'decodes and removes encoded html entities' do
        data.transform_htmlily_tag('&lt;span&gt;Casablanca&lt;/span&gt;').should eq 'Casablanca'
      end

      it 'removes cdata tags and html entities, leaving only the plain text' do
        text = '<![CDATA[<p>Ето кратко обобщение как ще протече защитата на проектите.</p>]]>'
        data.transform_htmlily_tag(text).should eq 'Ето кратко обобщение как ще протече защитата на проектите.'
      end

      it 'removes the new lines at the beginning/end and truncates any whitespace' do
        text = <<TEXT
<![CDATA[<p><a href="/quizzes/2">Резултатите от втория тест</a> са публикувани.
Ако някой иска да си види теста по време на защита на проектите, да пише предварително на fmi@ruby.bg.</p>]]>
TEXT
        expected = <<TEXT
Резултатите от втория тест са публикувани. Ако някой иска да си види теста по време на защита на проектите, да пише предварително на fmi@ruby.bg.
TEXT
        data.transform_htmlily_tag(text.chomp).should eq expected.chomp
      end
    end

    describe 'transform_date' do
      it 'returns an empty string for a text that is not a properly formatted date (RFC-822)' do
        data.transform_date('simple text').should eq ''
      end

      # example source: http://en.wikipedia.org/wiki/Unix_time#Notable_events_in_Unix_time
      it 'transforms an RFC-822 date into a unix timestamp' do
        data.transform_date('Fri, 13 Feb 2009 23:31:30 UTC').should eq 1234567890
      end
    end
  end
end