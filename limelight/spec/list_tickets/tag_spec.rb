require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "tag"

describe Tag do
  before(:each) do
    mock_lighthouse
    @project.stub!(:tag_names).and_return(["Tag One"])
    producer.production.current_project = @project
  end
  
  uses_scene :list_tickets
  
  before(:each) do
    @ticket_lister = mock("ticket_lister", :filter_by_tag => nil)
    scene.stub!(:ticket_lister).and_return(@ticket_lister)
    @tag_lister = mock("tag_lister", :activate => nil)
    scene.stub!(:tag_lister).and_return(@tag_lister)
  end
  
  it "should tell the ticket_lister to filter by tag" do
    @ticket_lister.should_receive(:filter_by_tag).with("Tag One")
    
    scene.find("tag_1").mouse_clicked(nil)
  end
  
  it "should tell the tag lister to activate itself" do
    @tag_lister.should_receive(:activate).with("tag_1")
    
    scene.find("tag_1").mouse_clicked(nil)
  end
end