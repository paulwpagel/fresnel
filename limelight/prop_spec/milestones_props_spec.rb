require File.dirname(__FILE__) + '/spec_helper'
require 'limelight/specs/spec_helper'

describe "Milestones Props" do
  before(:each) do
    setup_mocks
  end
  
  uses_scene :milestones
  
  it "should have an input for the title" do
    prop = scene.find("new_milestone_title")
    prop.name.should == "text_box"
  end
  
  it "should have an input for the goals" do
    prop = scene.find("new_milestone_goals")
    prop.name.should == "text_area"
  end

  it "should have an input for the due date" do
    prop = scene.find("new_milestone_due_on")
    prop.name.should == "text_box"
  end

  it "should have a button to create the milestone" do
    prop = scene.find("create_milestone")
    prop.name.should == "button"
    prop.players.should == "create_milestone"
  end
  
  it "should a link back to list_tickets" do
    scene.should_receive(:load).with('list_tickets')
    prop = scene.find("back_button")

    prop.button_pressed(nil)
  end
end
