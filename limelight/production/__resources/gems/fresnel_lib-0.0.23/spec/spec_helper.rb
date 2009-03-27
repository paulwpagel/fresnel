def add_to_search_path path
  $: << File.expand_path(File.dirname(__FILE__) + "/../#{path}")
end

[
  "lib"
].each {|path| add_to_search_path path}

require 'rubygems'
require 'spec'
