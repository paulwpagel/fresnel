require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/login_helper")
require File.expand_path(File.dirname(__FILE__) + "/project_helper")
require 'limelight/specs/spec_helper'

describe "Add Ticket Integration Test" do
  include LoginHelper
  include ProjectHelper
  
  it "should add a single ticket" do
    scene = login_scene(producer)
     
    login_with_credentials(scene)
    
    scene = current_scene(producer)
    
    scene.name.should == "project"
    scene.find("fresnel").mouse_clicked(nil)
    
    scene = current_scene(producer)

    press_button "add_ticket", scene
    
    scene = current_scene(producer)
    scene.name.should == "add_ticket"
    
    scene.find("title").text = "Test Title One"
    scene.find("description").text = "Test Description One"
    scene.find("milestones").text = "First Milestone"

    press_button "add_ticket_button", scene
    
    scene = current_scene(producer)
    
    scene.find("ticket_type").text = "All Tickets"
  end
  
  it "should add multiple tickets" do

  end
  
end