require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "ticket"

$testing = true

describe Ticket do
  uses_scene :ticket

  before(:each) do
    @milestones = [mock("milestone", :title => "milestone 1")]
    @project = mock("project", :tickets => [])
    @lighthouse_client = mock(LighthouseClient, :authenticate => nil, :add_ticket => nil, :milestones => @milestones, :find_project => @project)
    LighthouseClient.stub!(:new).and_return(@lighthouse_client)
  end
    
  it "should call client" do
    scene.find("title").text = "some title"
    scene.find("description").text = "some description"
    
    @lighthouse_client.should_receive(:authenticate)
    @lighthouse_client.should_receive(:add_ticket).with({:title => "some title"}, anything())
  
    scene.add_ticket
  end
  
  it "should clear out the text boxes when a ticket is added" do
    scene.find("title").text = "some title"
    scene.find("description").text = "some description"
  
    scene.add_ticket
    
    scene.find("title").text.should == ""
    scene.find("description").text.should == ""
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
  
  it "should have a view method shows a ticket" do
    scene.should_receive(:load).with("view_ticket")
    
    scene.view(4)
  end
  
  it "should find the ticket with an id on view" do
    @lighthouse_client.should_receive(:find_project).with(anything()).and_return(@project)
    
    scene.view('asdf')
  end
  
  it "should get the ticket with the proper id from the project" do
    ticket_one = mock("ticket", :id => 123)
    ticket_two = mock("ticket", :id => 456)
    @project.stub!(:tickets).and_return([ticket_one, ticket_two])
    
    scene.view(456)
    
    scene.production.current_ticket.should == ticket_two
  end
  
end

describe Ticket, "load_tickets" do
  uses_scene :ticket

  before(:each) do
    @project = mock("project", :tickets => [mock("ticket", :title => nil, :id => "123", :state => nil)])
    @prop = mock("prop")
    @lighthouse_client = mock(LighthouseClient, :find_project => @project)
    LighthouseClient.stub!(:new).and_return(@lighthouse_client)
    
    @child = mock("prop", :add => nil)
    scene.stub!(:children).and_return([@child])
  end
  
  it "should load the tickets from the project" do
    @lighthouse_client.should_receive(:find_project).with(anything()).and_return(@project)
    
    scene.load_tickets
  end
  
  it "should make a prop for each ticket on the project" do
    Limelight::Prop.should_receive(:new).with(hash_including(:id => "ticket_123")).and_return(@prop)
     
    scene.load_tickets
  end
  
  it "should add the prop to the scene" do
    Limelight::Prop.stub!(:new).and_return(@prop)
    @child.should_receive(:add).with(@prop)
    
    scene.load_tickets
  end
end

describe Ticket, "Props" do
  uses_scene :ticket
  
  it "should have title and description" do
    scene.find("title").should_not be(nil)
    scene.find("description").should_not be(nil)
    scene.find("milestones").should_not be(nil)
  end

end

describe Ticket, "Limelight event mappings" do
  uses_scene :ticket
  
  before(:each) do
    @event = nil
  end
  it "should call add_ticket on " do
    scene.should_receive(:add_ticket)
    
    scene.button_pressed(@event)
  end
  
end
