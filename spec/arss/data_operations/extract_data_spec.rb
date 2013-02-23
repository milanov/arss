# encoding: utf-8

require 'spec_helper'

module Arss
  describe ExtractData do
    let(:data) do
      Class.new.extend(ExtractData)
    end

    describe 'extract_tag_text' do
      it 'returns an empty string when there is no such tag' do
        data.extract_tag_text('simple text', 'div').should be_empty
      end

      it 'extracts the text from a simple tag' do
        data.extract_tag_text('<span>ham</span>', 'span').should eq 'ham'
      end

      it 'does not get confused with tricky tags' do
        data.extract_tag_text('<spanak>ham</span>', 'span').should be_empty
      end

      it 'extracts the text from a tag with attributes' do
        text = <<-TEXT
        Frankly, my dear,
        I don't <span style="color: red;">give</span> a damn.
        TEXT
        data.extract_tag_text(text, 'span').should eq 'give'
      end

      it 'works with multiline text in tags' do
        text = <<TEXT
<line>I'm going
 to make him
 an offer
 he can't refuse.</line>
TEXT
        data.extract_tag_text(text, 'line').should eq "I'm going\n to make him\n an offer\n he can't refuse."
      end

      it 'supports unicode characters' do
        data.extract_tag_text('<title>Новини</title>', 'title').should eq 'Новини'
      end

      it 'works with multiline unicode text in tags' do
        text = <<TEXT
<title>Горещи
новини</title>
</title>
TEXT
        data.extract_tag_text(text, 'title').should eq "Горещи\nновини"
      end
    end

    # TODO here :)
    # describe 'extract_subtag_text' do
    #   it 'returns an empty string when there is no such tag' do
    #     data.extract_subtag_text('simple text', 'div').should be_empty
    #   end

    #   it 'extracts only direct subtags' do
    #     data.extract_subtag_text('<div><p>simple text</p></div>', 'p').should eq ''
    #   end

    # end

    describe 'list_same_tag_data' do
      it 'returns an empty list when there are no such tags' do
        data.list_same_tag_data('simple text', 'div').should be_empty
      end

      it 'extracts data from simple tags' do
        data.list_same_tag_data('<b>simple</b><b>text</b>', 'b').should eq %w(simple text)
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

      it 'supports unicode characters' do
        text = <<TEXT
<ul>Едно</ul>
<ul>Две</ul>
<ul>Три</ul>
TEXT
        data.list_same_tag_data(text, 'ul').should eq %w(Едно Две Три)
      end

      it 'works with multiline unicode text' do
        text = <<TEXT
<quote>Няма съвпадения.
Има само илюзия за съвпадения.</quote>
TEXT
        data.list_same_tag_data(text, 'quote').should eq ["Няма съвпадения.\nИма само илюзия за съвпадения."]
      end
    end
  end
end