require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'limelight/specs/spec_helper'

describe "Add Ticket Integration Test" do
  
  it "should add a single ticket" do
    scene = producer.open_scene("login", producer.theater["default"])
     
    scene.find("account").text = "fresnel"
    scene.find("username").text = "Tommy James"
    scene.find("password").text = "abracadabrah"
    
    sleep 1
    
    scene.find("login_button").button_pressed(nil)
    
    sleep 1
    
    scene = producer.production.theater['default'].current_scene
    
    scene.name.should == "ticket"

    scene.find("add_ticket").button_pressed(nil)
    
    scene = producer.production.theater['default'].current_scene
    scene.name.should == "add_ticket"

    sleep 1
    
    scene.find("title").text = "Test Title One"
    scene.find("description").text = "Test Description One"
    sleep 1
    scene.find("add_ticket_button").button_pressed(nil)
    
    sleep 1
    scene = producer.production.theater['default'].current_scene
    sleep 1
  end
end