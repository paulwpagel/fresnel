require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "create_ticket"

describe CreateTicket do

  before(:each) do
    mock_lighthouse
    producer.production.current_project = mock('Project', :open_tickets => [], 
                                                          :milestone_titles => ["Milestone One", "Milestone Two"],
                                                          :user_names => ["Name"])
  end

  uses_scene :list_tickets

  it "should add a blank row with the information for adding a ticket" do
    scene.find('add_ticket_button').button_pressed(nil)
    
    add_ticket_group = scene.find('add_ticket_group')
    add_ticket_group.should_not be_nil
    scene.ticket_lister.children.should include(add_ticket_group)    
  end
  
  it "should have an input for the ticket title" do
    scene.find('add_ticket_button').button_pressed(nil)

    title = scene.find("add_ticket_title")
    title.should_not be_nil
  end
  
  it "should have the description" do
    scene.find('add_ticket_button').button_pressed(nil)

    description = scene.find("add_ticket_description")
    description.should_not be_nil
  end
  
  it "should have a combo_box for milestones" do
    scene.find('add_ticket_button').button_pressed(nil)

    milestones = scene.find("add_ticket_milestone")
    milestones.should_not be_nil
    milestones.name.should == "combo_box"
    milestones.choices.should == ["None", "Milestone One", "Milestone Two"]
  end
  
  it "should have a combo box for who is responsible" do
    scene.find('add_ticket_button').button_pressed(nil)
    
    responsible = scene.find("add_ticket_responsible_person")
    responsible.should_not be_nil
    responsible.name.should == "combo_box"
    responsible.choices.should == ["None", "Name"]
  end
  
  it "should have tags" do
    scene.find('add_ticket_button').button_pressed(nil)
    
    tags = scene.find("add_ticket_tags")
    tags.should_not be_nil
    tags.name.should == "text_box"
  end
  
  it "should have an add button" do
    scene.find("add_ticket_button").button_pressed(nil)
    
    button = scene.find("submit_add_ticket_button")
    button.should_not be_nil
    button.name.should == "button"
    button.players.should include("add_ticket")
  end
  
  it "should have a cancel button" do
    scene.find("add_ticket_button").button_pressed(nil)
    
    button = scene.find("cancel_add_ticket_button")
    button.should_not be_nil
    button.name.should == "button"
    button.players.should include("cancel_add_ticket")
  end
end
