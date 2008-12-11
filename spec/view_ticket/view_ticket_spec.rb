require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "view_ticket"

$testing = true

describe ViewTicket, "load_current_ticket" do
  uses_scene :view_ticket
  
  before(:each) do
    @client = mock("client", :milestone_title => "Goal One")
    LighthouseClient.stub!(:new).and_return(@client)
    scene.production.current_ticket = mock("ticket", :title => 'title', :assigned_user_name => "Roger", :state => "open", :milestone_id => 12345)
  end
  
  it "should make a prop on the scene for the current_ticket" do    
    scene.load_current_ticket

    prop = scene.find('ticket_title')
    prop.text.should == "title"
    prop.name.should == "ticket_title"
  end
  
  it "should make a prop on the scene for the assigned_user_name" do
    scene.load_current_ticket

    prop = scene.find('ticket_assigned_user')
    prop.text.should include("Roger")
    prop.name.should == "ticket_assigned_user"
  end
  
  it "should make a prop on the scene for the ticket_state" do
    scene.load_current_ticket

    prop = scene.find('ticket_state')
    prop.text.should == "Open"
    prop.name.should == "ticket_state"
  end
  
  it "should get the milestone title from the client" do
    @client.should_receive(:milestone_title).with(anything(), 12345)
    
    scene.load_current_ticket
  end
  
  it "should add a prop for the milestone_title" do
    scene.load_current_ticket

    prop = scene.find('ticket_milestone')
    prop.text.should == "Goal One"
    prop.name.should == "ticket_milestone"
  end
  
end