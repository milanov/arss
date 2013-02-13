# encoding: utf-8

require 'spec_helper'

module Arss
  describe ExtractData do
    let(:data) do
      Class.new.extend(ExtractData)
    end

    describe 'extract_text_from_tag' do
      it 'returns an empty string when there is no such tag' do
        data.extract_text_from_tag('simple text', 'div').should be_empty
      end

      it 'extracts the text from a simple tag' do
        data.extract_text_from_tag('<span>ham</span>', 'span').should eq 'ham'
      end

      it 'extracts the text from a tag with attributes' do
        text = <<-TEXT
        Frankly, my dear,
        I don't <span style="color: red;">give</span> a damn.
        TEXT
        data.extract_text_from_tag(text, 'span').should eq 'give'
      end

      it 'works with multiline text in a tag' do
        text = <<TEXT
<line>I'm going
 to make him
 an offer
 he can't refuse.</line>
TEXT
        data.extract_text_from_tag(text, 'line').should eq "I'm going\n to make him\n an offer\n he can't refuse."
      end
    end

    describe 'list_same_tag_data' do
      it 'returns an empty list when there are no such tags' do
        data.list_same_tag_data('simple text', 'div').should be_empty
      end

      it 'extracts data from simple tags' do
        data.list_same_tag_data('<b>simple</b><b>text</b>', 'b').should eq ['simple', 'text']
      end

      it 'extracts data from tags with attributes' do
        text = <<-TEXT
        <oz year="1939">Toto</oz><oz>, I've got a feeling we're not in Kansas anymore.</oz>
        TEXT
        data.list_same_tag_data(text, 'oz').should eq ["Toto", ", I've got a feeling we're not in Kansas anymore."]
      end

      it 'works with multiline text in the tags' do
        text = <<TEXT
<movie>A census taker once tried to test me.
I ate his liver with some fava beans and a nice Chianti.</movie>
TEXT
        expected = ["A census taker once tried to test me.\nI ate his liver with some fava beans and a nice Chianti."]
        data.list_same_tag_data(text, 'movie').should eq expected
      end
    end
  end
end