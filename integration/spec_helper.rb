def add_to_search_path path
  $: << File.expand_path(File.dirname(__FILE__) + "/../#{path}")
end

[
  "production/ticket/players",
  "production/ticket/stagehands",
  "production/view_ticket/players",
  "production/login/players",
  "production/add_ticket/players",
  "lib"
].each {|path| add_to_search_path path}

require 'rubygems'
require 'spec'

$PRODUCTION_PATH = File.expand_path(File.dirname(__FILE__) + "/../production")

