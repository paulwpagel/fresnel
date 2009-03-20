$adapter = "memory"
def add_to_search_path path
  $: << File.expand_path(File.dirname(__FILE__) + "/../#{path}")
end

[
  "production/ticket/players",
  "production/ticket/stagehands",
  "production/view_ticket/players",
  "production/login/players",
  "production/add_ticket/players",
  "production",
  "production/lib",
  "production/__resources/gems/fresnel_lib-0.0.16/lib"
].each {|path| add_to_search_path path}

require 'rubygems'
require 'spec'
require 'limelight/specs/spec_helper'
require 'lighthouse/adapter'
$PRODUCTION_PATH = File.expand_path(File.dirname(__FILE__) + "/../production")

$visual = false

def press_button(button_prop_name, scene)
  sleep 2 if $visual
  button = scene.find(button_prop_name)
  raise "There is no button named #{button_prop_name} in scene #{scene.name}" unless button
  button.button_pressed(@event)
  sleep 2 if $visual
end

def current_scene(producer)
    return producer.production.theater['default'].current_scene
end

def login_scene(producer)
  return producer.open_scene("login", producer.theater["default"])
end