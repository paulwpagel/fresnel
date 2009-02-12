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
  
  it "should have a mouse_clicked event" do
    click_tag
  end
  
  it "should get the tickets to show from the current_project" do
    @project.should_receive(:tickets_for_tag).with("Tag One").and_return([])
    
    click_tag
  end
  
  it "should show the found tickets" do
    tickets = [mock("ticket")]
    @project.stub!(:tickets_for_tag).and_return(tickets)
    scene.ticket_lister.should_receive(:show_these_tickets).with(tickets)
    
    click_tag
  end
  
  def click_tag
    scene.find("tag_1").mouse_clicked(nil)
  end
end