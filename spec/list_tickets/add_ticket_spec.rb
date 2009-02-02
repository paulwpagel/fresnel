require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "add_ticket"

describe AddTicket do

  before(:each) do
    mock_lighthouse
    producer.production.current_project = @project
  end

  uses_scene :list_tickets
  
  it "should call client" do 
    scene.find("add_ticket_button").button_pressed(nil) #TODO - PWP - Remove this tests dependency on the create_button player
    scene.find("add_ticket_title").text = "some title"
    scene.find("add_ticket_description").text = "some description"
    scene.find("add_ticket_tags").text = "One Two"
    
    @project.should_receive(:user_id).with("None").and_return(234)    
    @project.should_receive(:milestone_id).with("None").and_return(998)

    @lighthouse_client.should_receive(:add_ticket).with(
                                                        { :title => "some title", 
                                                          :description => "some description", 
                                                          :assigned_user_id => 234, 
                                                          :tags => "One Two",
                                                          :milestone_id => 998
                                                          }, @project)
   scene.find("submit_add_ticket_button").button_pressed(nil)                                                          
  end
  
  it "should remove add_ticket_group_prop when adding the ticket" do
    scene.find("add_ticket_button").button_pressed(nil) #TODO - PWP - Remove this tests dependency on the create_button player
    scene.find("add_ticket_title").text = "some title"
    scene.find("add_ticket_description").text = "some description"
    scene.find("add_ticket_responsible_person").text = "Name"
    scene.find("add_ticket_tags").text = "One Two"
    scene.find("add_ticket_milestone").text = "milestone 1"
    
    scene.find("add_ticket_group").should_not be_nil
    
    scene.find("submit_add_ticket_button").button_pressed(nil)
    
    scene.find("add_ticket_group").should be_nil
    scene.find("add_ticket_milestone").should be_nil
    scene.find("add_ticket_tags").should be_nil
    scene.find("submit_add_ticket_button").should be_nil
  end
  
  it "should update project list" do 
    @ticket = mock('ticket')
    scene.find("add_ticket_button").button_pressed(nil) #TODO - PWP - Remove this tests dependency on the create_button player
    
    @project.should_receive(:update_tickets).ordered
    @project.should_receive(:open_tickets).ordered.and_return([@ticket])
    scene.ticket_lister.should_receive(:show_these_tickets).with([@ticket])
    
    scene.find("submit_add_ticket_button").button_pressed(nil)
  end
    
end