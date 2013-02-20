# encoding: utf-8

# add the current directory to the load path
$LOAD_PATH.unshift(File.dirname(__FILE__))

# the order in which the files are included matters :)
require 'arss/feeds_specifications/rss'

require 'arss/data_operations/remove_data'
require 'arss/data_operations/extract_data'
require 'arss/data_operations/transform_data'
require 'arss/data_operations/parse_data'

require 'arss/feed_parser'