require File.dirname(__FILE__) + '/../spec_helper'
require 'limelight/specs/spec_helper'

describe "Props" do  
  uses_scene :add_project
  
  it "should have a box to enter in the project name" do
    prop = scene.find("project_name")

    prop.should_not be_nil
    prop.name.should == "text_box"
  end

  it "should have a box for public" do
    prop = scene.find("public")

    prop.should_not be_nil
    prop.name.should == "combo_box"
    prop.choices.should include("True")
    prop.choices.should include("False")
  end
  
  it "should have a add project button" do
    prop = scene.find("add_project_button")

    prop.should_not be_nil
    prop.name.should == "button"
    prop.players.should include("add_project")
    prop.text.should == "Add Project"
  end

end