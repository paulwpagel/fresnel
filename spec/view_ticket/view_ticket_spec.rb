require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "view_ticket"

$testing = true

describe ViewTicket, "load_current_ticket" do
  uses_scene :view_ticket
  
  before(:each) do
    scene.production.current_ticket = mock("ticket", :title => 'title', :assigned_user_name => "Roger")
    scene.load_current_ticket
  end
  
  it "should make a prop on the scene for the current_ticket" do    
    title = scene.find('ticket_title')
    title.text.should == "title"
    title.name.should == "ticket_title"
  end
  
  it "should make a prop on the scene for the assigned_user_name" do
    title = scene.find('ticket_assigned_user')
    title.text.should include("Roger")
    title.name.should == "ticket_assigned_user"
  end
  
end