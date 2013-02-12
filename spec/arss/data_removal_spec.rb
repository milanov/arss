# encoding: utf-8

require 'spec_helper'

module Arss
  describe DataRemoval do
    let(:data) do
      Class.new.extend(DataRemoval)
    end

    describe 'remove_comments' do
      it 'can remove empty comments' do
        data.remove_comments('<!---->').should eq ''
      end

      it 'can remove multiline comments' do
        text = <<TEXT
simple <!--multiline
comment
here-->text
TEXT
        data.remove_comments(text.chomp).should eq 'simple text'
      end

      it 'can remove more than one comment' do
        text = <<TEXT
<news>new</news><!-- This is a comment -->
<title>lines</title><!-- This is another comment -->
TEXT
        data.remove_comments(text.chomp).should eq "<news>new</news>\n<title>lines</title>"
      end

      it 'does not get confused with nested comments' do
        text = <<TEXT
<!-- <!--comm
ent-->nested comments
TEXT
        data.remove_comments(text.chomp).should eq 'nested comments'
      end
    end

    describe 'remove_cdata' do
      it 'works on an empty string' do
        data.remove_cdata('').should eq ''
      end

      it 'does not remove anything unless wrapped in cdata tags' do
        data.remove_cdata('simple text').should eq 'simple text'
      end

      it 'leaves the text in the cdata tags' do
        data.remove_cdata('<![CDATA[just text]]>').should eq 'just text'
      end

      it 'does not get confused by brackets' do
        data.remove_cdata('<![CDATA[text with [][] brackets]]>').should eq 'text with [][] brackets'
      end

      it 'works with more than one cdata tag' do
        text = 'A text with <![CDATA[multiple]]> cdata <![CDATA[tags]]>.'
        data.remove_cdata(text).should eq 'A text with multiple cdata tags.'
      end

      it 'works with multiline text' do
        text = <<TEXT
text with
 new
 lines
TEXT
        data.remove_cdata(text.chomp).should eq "text with\n new\n lines"
      end
    end

    describe 'remove_html_tags' do
      it 'works on an empty string' do
        data.remove_html_tags('').should eq ''
      end

      it 'works on a simple text which does not have any html tags' do
        data.remove_html_tags('simple text').should eq 'simple text'
      end

      it 'works with multiple tags with no attributes' do
        text = <<TEXT
another <span>html</span> <em>text</em>
TEXT
        data.remove_html_tags(text.chomp).should eq 'another html text'
      end

      it 'works with multiline html tags' do
        text = <<TEXT
<div>Text span across
multiple
lines.</div>
TEXT
        data.remove_html_tags(text.chomp).should eq "Text span across\nmultiple\nlines."
      end

      it 'works with tags with attributes' do
        text = <<TEXT
<div style="width: 200px; height: 200px; float: left;">
A div, but a div with a style.
</div>
TEXT
        data.remove_html_tags(text.chomp).should eq "\nA div, but a div with a style.\n"
      end
    end
  end
end