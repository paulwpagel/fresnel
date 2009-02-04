require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "save_ticket"

describe SaveTicket, "on_click" do
  before(:each) do
    mock_lighthouse
    @mock_ticket = mock("ticket", :id => 12345, :title => "", :assigned_user_name => "", :state => "new", :state= => nil, :title= => nil, :tag => nil,
          :milestone_id => 123, :description => "", :versions => [], :save => nil, :milestone_id= => nil, :new_comment= => nil, :assigned_user_id= => nil,
          :tag= => nil, :formatted_age => nil)
    producer.production.current_ticket = @mock_ticket
    @project.stub!(:user_id).and_return("User ID")
    @project.stub!(:milestone_id).and_return("Milestone ID")
    @project.stub!(:open_tickets).and_return([@mock_ticket])
    @project.stub!(:user_names).and_return(["User One", "User Two", "User Three"])
    producer.production.current_project = @project
    @lighthouse_client.stub!(:ticket).and_return(@mock_ticket)
  end
  
  uses_scene :list_tickets

  before(:each) do
    scene.find("ticket_12345").mouse_clicked(nil)
  end
  
  it "should set the ticket's title" do
    prop = scene.find("ticket_title")
    prop.text = "New Title"
    @mock_ticket.should_receive(:title=).with("New Title")
   
    press_save_button
  end
  
  it "should set the ticket's state" do
    prop = scene.find("ticket_state")
    prop.value = "open"
    @mock_ticket.should_receive(:state=).with("open")
   
    press_save_button
  end
  
  it "should set the ticket's tag" do
    prop = scene.find("ticket_tag")
    prop.text = "one two"
    @mock_ticket.should_receive(:tag=).with("one two")
   
    press_save_button
  end
  
  it "should save the ticket" do
    @mock_ticket.should_receive(:save)
    
    press_save_button
  end
  
  it "should get the milestone id from its title" do
    prop = scene.find("ticket_milestone")
    prop.choices = ["Some Milestone"]
    prop.value = "Some Milestone"
    @project.should_receive(:milestone_id).with("Some Milestone")
    
    press_save_button
  end
  
  it "should set the milestone id on the ticket" do
    @mock_ticket.should_receive(:milestone_id=).with("Milestone ID")
    
    press_save_button
  end
  
  it "should set the new comment for the ticket" do
    prop = scene.find("ticket_comment")
    prop.text = "Some Comment"
    @mock_ticket.should_receive(:new_comment=).with("Some Comment")
    
    press_save_button
  end
    
  it "should get the id for the new assigned user" do
    prop = scene.find("ticket_assigned_user")
    prop.value = "User Two"
    @project.should_receive(:user_id).with("User Two")
    
    press_save_button
  end

  it "should set the tickets assigned_user_id to the found user id" do
    @mock_ticket.should_receive(:assigned_user_id=).with("User ID")
    
    press_save_button
  end
  
  it "should re-find the ticket" do
    @lighthouse_client.should_receive(:ticket).with(12345, @project).and_return(@mock_ticket)
    
    press_save_button
  end
  
  it "should save the new ticket in the current ticket" do
    producer.production.should_receive(:current_ticket=).with(@mock_ticket)
    
    press_save_button
  end
  
  it "should reload the view ticket scene" do
    scene.should_receive(:load).with("view_ticket")
    
    press_save_button
  end
  
  def press_save_button
    scene.find("save_button").button_pressed(nil)
  end
end
