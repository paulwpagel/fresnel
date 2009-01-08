require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "save_ticket"

describe SaveTicket, "on_click" do
  before(:each) do
    mock_lighthouse
    Lighthouse::LighthouseApi::User.stub!(:user_id_for_name).and_return("User ID")
    @mock_ticket = mock("ticket", :title => "", :assigned_user_name => "", :state => "new", :state= => nil, :title= => nil,
          :milestone_id => 123, :description => "", :versions => [], :save => nil, :milestone_id= => nil, :new_comment= => nil, :assigned_user_id= => nil)
    producer.production.current_ticket = @mock_ticket
    @mock_project = mock("project", :milestone_id => "Milestone ID", :all_states => ["open"], :milestone_title => nil,
                                    :milestone_titles => ["Goal One", "Goal Two"], :user_names => ["User One", "User Two", "User Three"])
    producer.production.current_project = @mock_project
  end
  
  uses_scene :view_ticket

  it "should set the ticket's title" do
    prop = scene.find("ticket_title")
    prop.text = "New Title"
    @mock_ticket.should_receive(:title=).with("New Title")
   
    press_button
  end
  
  it "should set the ticket's state" do
    prop = scene.find("ticket_state")
    prop.value = "open"
    @mock_ticket.should_receive(:state=).with("open")
   
    press_button
  end
  
  it "should save the ticket" do
    @mock_ticket.should_receive(:save)
    
    press_button
  end
  
  it "should get the milestone id from its title" do
    prop = scene.find("ticket_milestone")
    prop.choices = ["Some Milestone"]
    prop.value = "Some Milestone"
    @mock_project.should_receive(:milestone_id).with("Some Milestone")
    
    press_button
  end
  
  it "should set the milestone id on the ticket" do
    @mock_ticket.should_receive(:milestone_id=).with("Milestone ID")
    
    press_button
  end
  
  it "should set the new comment for the ticket" do
    prop = scene.find("ticket_comment")
    prop.text = "Some Comment"
    @mock_ticket.should_receive(:new_comment=).with("Some Comment")
    
    press_button
  end
  
  it "should reload the view ticket scene" do
    scene.should_receive(:load).with("view_ticket")
    
    press_button
  end
  
  it "should get the id for the new assigned user" do
    prop = scene.find("ticket_assigned_user")
    prop.value = "User Two"
    Lighthouse::LighthouseApi::User.should_receive(:user_id_for_name).with("User Two")
    
    press_button
  end

  it "should set the tickets assigned_user_id to the found user id" do
    @mock_ticket.should_receive(:assigned_user_id=).with("User ID")
    
    press_button
  end
  
  def press_button
    scene.find("save_button").button_pressed(nil)
  end
end
