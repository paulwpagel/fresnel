require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "add_ticket"

describe AddTicket do
  
  before(:each) do
    mock_lighthouse
    @milestones = [mock("milestone", :title => "milestone 1")]
    @project = mock("Project", :milestones => [], :user_names => ["Name"])
    producer.production.current_project = @project
  end
  
  uses_scene :add_ticket
      
  it "should call client" do
    scene.find("title").text = "some title"
    scene.find("description").text = "some description"
    scene.find("responsible_person").text = "Name"
    scene.find("tags").text = "One Two"
    
    @project.should_receive(:user_id).with("Name").and_return(234)    
    scene.should_receive(:load).with("list_tickets")

    @lighthouse_client.should_receive(:add_ticket).with({:title => "some title", :description => "some description", :assigned_user_id => 234, :tags => "One Two"}, @project)
  
    scene.add_ticket
  end
      
  it "should give a choice for milestones" do
    @project.should_receive(:milestones).and_return(@milestones)
    
    scene.load_milestones
    
    milestone_input = scene.find("milestones")
    milestone_input.choices.should include("milestone 1")
  end
  
  it "should have a choice for no milestone" do
    scene.load_milestones
    
    milestone_input = scene.find("milestones")
    milestone_input.choices.should include("None")
  end
  
  it "should load users" do
    @project.should_receive(:user_names).and_return(["Name"])
    scene.load_users
    
    responsible_person = scene.find("responsible_person")
    responsible_person.choices.should include("Name")
  end
  
  it "should have a choice for no user" do
    scene.load_users
    
    responsible_person = scene.find("responsible_person")
    responsible_person.choices.should include("None")
  end
end

describe AddTicket, "Props" do
  before(:each) do
    mock_lighthouse
    @project = mock("Project", :milestones => [], :user_names => ["Name"])
    producer.production.current_project = @project
  end
  
  uses_scene :add_ticket
  
  it "should have title and description" do
    scene.find("title").should_not be_nil
    scene.find("description").should_not be_nil
    scene.find("milestones").should_not be_nil
    scene.find("responsible_person").should_not be_nil
    scene.find("tags").should_not be_nil
  end
  
  it "should have add ticket button" do
    button = scene.find("add_ticket_button")
    button.should_not be_nil

    button.players.should  == "add_ticket"
  end

end

describe AddTicket, "Limelight event mappings" do

  before(:each) do
    @event = nil
    mock_lighthouse
    @project = mock("Project", :milestones => [], :user_names => ["Name"])
    producer.production.current_project = @project
  end
  
  uses_scene :add_ticket
  
  it "should call add_ticket on " do
    scene.should_receive(:add_ticket)
    
    scene.button_pressed(@event)
  end
  
end
