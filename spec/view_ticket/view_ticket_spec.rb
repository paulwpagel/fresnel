require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "view_ticket"

describe ViewTicket, "load_current_ticket" do
  
  before(:each) do
    mock_lighthouse
    @lighthouse_client.stub!(:milestone_title).and_return("Goal One")
    producer.production.current_ticket = mock("ticket", :title => 'title', :assigned_user_name => "Roger", :state => "open",
                                                     :milestone_id => 12345, :description => "Some Description")
  end
  
  uses_scene :view_ticket
  
  it "should make a prop on the scene for the current ticket title" do    
    prop = scene.find('ticket_title')
    prop.text.should == "title"
    prop.name.should == "ticket_title"
  end
  
  it "should make a prop on the scene for the assigned_user_name" do
    prop = scene.find('ticket_assigned_user')
    prop.text.should include("Roger")
    prop.name.should == "ticket_assigned_user"
  end
  
  it "should make a prop on the scene for the ticket_state" do
    prop = scene.find('ticket_state')
    prop.text.should == "Open"
    prop.name.should == "ticket_state"
  end
  
  it "should make a prop on the scene for the ticket_description" do
    prop = scene.find('ticket_description')
    prop.text.should == "Some Description"
    prop.name.should == "ticket_description"
  end
  
  it "should add a prop for the milestone_title" do
    prop = scene.find('ticket_milestone')
    prop.text.should == "Goal One"
    prop.name.should == "ticket_milestone"
  end
  
end
