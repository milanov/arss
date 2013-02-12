# encoding: utf-8

# add the lib directory to the load path
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))

# the order in which the files are included matters :)
require 'arss/data_removal'
require 'arss/data_transform'
require 'arss/data_extract'
require 'arss/data_parser/channel_parser'
require 'arss/data_parser/textinput_parser'
require 'arss/data_parser/image_parser'
require 'arss/data_parser/items_parser'
require 'arss/rss_parser'