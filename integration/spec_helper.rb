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

$visual = true

def press_button(button_prop_name, scene)
  sleep 1 if $visual
  scene.find(button_prop_name).button_pressed(@event)
  sleep 1 if $visual
end

