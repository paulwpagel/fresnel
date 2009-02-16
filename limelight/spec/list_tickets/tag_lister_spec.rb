require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "tag_lister"

describe TagLister do
  before(:each) do
    mock_lighthouse
    @project.stub!(:tag_names).and_return(["Tag One", "Tag Two"])
    producer.production.current_project = @project
  end
  
  uses_scene :list_tickets
  
  before(:each) do
    scene.tag_lister.show_project_tags
  end
  
  it "should have a prop for the heading" do
    heading = scene.find("tag_heading")
    heading.should_not be_nil
    heading.name.should == "heading"
    heading.text.should == "Tags"
  end

  it "should make a prop for one tag" do
    tag_one = scene.find("tag_1")
    tag_one.name.should == "tag"
    tag_one.text.should == "Tag One"
    scene.tag_lister.children.should include(tag_one)
  end
  
  it "should make a prop for the second tag" do
    tag_two = scene.find("tag_2")
    tag_two.name.should == "tag"
    tag_two.text.should == "Tag Two"
    scene.tag_lister.children.should include(tag_two)
  end
  
end

describe TagLister, "No tags" do
  before(:each) do
    mock_lighthouse
    @project.stub!(:tag_names).and_return([])
    producer.production.current_project = @project
  end
  
  uses_scene :list_tickets
  
  before(:each) do
    scene.tag_lister.show_project_tags
  end
  
  it "should not have a prop for the heading" do
    heading = scene.find("tag_heading")
    heading.should be_nil
  end
end
