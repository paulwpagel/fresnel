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
    scene.find("edit_milestone_123").mouse_clicked(nil)
  end
  
  it "should have an input field for the title" do
    prop = scene.find("milestone_title_123")
    prop.name.should == "text_box"
    # prop.text.should == "Milestone 123"
  end
  
  it "should have a save_button" do
    prop = scene.find("save_milestone_123")
    prop.name.should == "button"
    prop.players.should == "save_milestone"
  end
end