require File.dirname(__FILE__) + '/spec_helper'
require 'limelight/specs/spec_helper'

describe "Milestones Props" do
  before(:each) do
    setup_mocks
    milestone_one = mock("milestone", :title => "Milestone 123", :id => 123)
    milestone_two = mock("milestone", :title => "Milestone 456", :id => 456)
    @project.stub!(:milestones).and_return([milestone_one, milestone_two])
  end
  
  uses_scene :list_tickets
  
  before(:each) do
    scene.find("configure_milestones").mouse_clicked(nil)
  end
  
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
  
  it "should a link to close the page" do
    prop = scene.find("close_configure_milestones")
    prop.name.should == "button"
    prop.players.should == "close_configure_milestones"
  end
  
  it "should have everything inside a wrapper" do
    prop = scene.find("configure_milestones_wrapper")
    prop.should_not be_nil
  end
  
  it "should have a prop to edit one milestone" do
    prop = scene.find("edit_milestone_123")
    prop.name.should == "edit_milestone"
  end

  it "should have a prop to edit a second milestone" do
    prop = scene.find("edit_milestone_456")
    prop.name.should == "edit_milestone"
  end
  
  it "should wrap the existing milestones" do
    prop = scene.find("existing_milestones")
    prop.name.should == "existing_milestones"
  end
end
