require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'limelight/specs/spec_helper'
require "ticket"

describe Ticket do
  uses_scene :ticket

  before(:each) do
    @project = mock("project", :open_tickets => [])
    @lighthouse_client = mock(LighthouseClient, :find_project => @project)
    LighthouseClient.stub!(:new).and_return(@lighthouse_client)
    scene.stub!(:load)
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
    @project.stub!(:open_tickets).and_return([ticket_one, ticket_two])
    
    scene.view(456)
    
    scene.production.current_ticket.should == ticket_two
  end
  
  it "should have a drop down to view different tickets" do
    sort_tickets = scene.find('sort_tickets')

    sort_tickets.players.should == "list_ticket"
  end
  
  it "should have a name" do
    sort_tickets = scene.find('sort_tickets')

    sort_tickets.name.should == "combo_box"
  end
  
  it "should have different options" do
    sort_tickets = scene.find('sort_tickets')
    
    sort_tickets.choices.should include("Open Tickets")
    sort_tickets.choices.should include("All Tickets")
  end
end

describe Ticket, "load_tickets" do
  uses_scene :ticket

  before(:each) do
    @project = mock("project", :open_tickets => [mock("ticket", :title => nil, :id => "123", :state => nil)])
    @prop = mock("prop")
    @lighthouse_client = mock(LighthouseClient, :find_project => @project)
    LighthouseClient.stub!(:new).and_return(@lighthouse_client)
    
    @child = mock("prop", :add => nil)
    scene.stub!(:find_by_name).and_return([@child])
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
