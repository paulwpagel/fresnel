require File.dirname(__FILE__) + '/spec_helper'
require 'limelight/specs/spec_helper'

describe "Milestones Props" do
  before(:each) do
  end
  
  uses_scene :milestones
  
  it "should an input for the title" do
    prop = scene.find("new_milestone_title")
    prop.name.should == "text_box"
  end
  
  it "should have a button to create the milestone" do
    prop = scene.find("create_milestone")
    prop.name.should == "button"
    prop.players.should == "create_milestone"
  end
end
