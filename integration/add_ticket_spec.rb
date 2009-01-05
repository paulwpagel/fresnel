require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'limelight/specs/spec_helper'

describe "Add Ticket Integration Test" do
  
  it "should add a single ticket" do
    scene = producer.open_scene("login", producer.theater["default"])
     
    scene.find("account").text = "fresnel"
    scene.find("username").text = "Tommy James"
    scene.find("password").text = "abracadabrah"

    press_button("login_button", scene)
    
    scene = producer.production.theater['default'].current_scene
    scene.name.should == "project"
    
    scene.find("fresnel").mouse_clicked(nil)
    scene = producer.production.theater['default'].current_scene

    press_button "add_ticket", scene
    
    scene = producer.production.theater['default'].current_scene
    scene.name.should == "add_ticket"
    
    scene.find("title").text = "Test Title One"
    scene.find("description").text = "Test Description One"
    scene.find("milestones").text = "First Milestone"

    press_button "add_ticket_button", scene
    
    scene = producer.production.theater['default'].current_scene
    
    scene.find("ticket_type").text = "All Tickets"
  end
end