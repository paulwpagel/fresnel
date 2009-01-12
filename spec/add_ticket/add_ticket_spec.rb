require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "add_ticket"

describe AddTicket do
  
  before(:each) do
    mock_lighthouse
    @milestones = [mock("milestone", :title => "milestone 1")]
    @lighthouse_client.stub!(:users_for_project).and_return([mock('user', :name => "Name")])
  end
  
  uses_scene :add_ticket
    
  it "should call client" do
    scene.find("title").text = "some title"
    scene.find("description").text = "some description"

    scene.stub!(:load)

    @lighthouse_client.should_receive(:add_ticket).with({:title => "some title", :description => "some description"}, anything())
  
    scene.add_ticket
  end
  
  it "should clear out the text boxes when a ticket is added" do
    scene.find("title").text = "some title"
    scene.find("description").text = "some description"
    scene.stub!(:load)
    
    scene.add_ticket
    
    scene.find("title").text.should == ""
    scene.find("description").text.should == ""
  end
  
  it "should load the view_ticket scene" do
    scene.find("title").text = "some title"
    scene.find("description").text = "some description"
    scene.should_receive(:load).with("list_tickets")
    
  
    scene.add_ticket
  end
  
  it "should give a choice for milestones" do
    @lighthouse_client.should_receive(:milestones).with(anything()).and_return(@milestones)
    
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
    @lighthouse_client.should_receive(:users_for_project).with("fresnel").and_return([mock('user', :name => "Name")])
    
    scene.load_users
    
    responsible_person = scene.find("responsible_person")
    responsible_person.choices.should include("Name")
  end
    
end

describe AddTicket, "Props" do
  before(:each) do
    mock_lighthouse
    @lighthouse_client.stub!(:users_for_project).and_return([mock('user', :name => "Name")])
  end
  
  uses_scene :add_ticket
  
  it "should have title and description" do
    scene.find("title").should_not be_nil
    scene.find("description").should_not be_nil
    scene.find("milestones").should_not be_nil
    scene.find("responsible_person").should_not be_nil
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
    @lighthouse_client.stub!(:users_for_project).and_return([mock('user', :name => "Name")])
  end
  
  uses_scene :add_ticket
  
  it "should call add_ticket on " do
    scene.should_receive(:add_ticket)
    
    scene.button_pressed(@event)
  end
  
end
