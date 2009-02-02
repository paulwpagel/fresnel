require File.dirname(__FILE__) + '/../spec_helper'
require 'list_tickets'

describe ListTickets do
  before(:each) do
    mock_lighthouse
    producer.production.current_project = @project
    @ticket_master = mock('ticket_master', :show_tickets => nil)
    TicketMaster.stub!(:new).and_return(@ticket_master)
    @scene = mock('scene')
  end
  
  uses_scene :list_tickets
  
  it "should have a ticket_lister" do
    lister = mock('lister')
    @scene.should_receive(:find).with("ticket_lister").and_return(lister)
    
    @scene.ticket_lister.should == lister
  end
  
  it "should find the age image" do
    scene.find("age_image").style.background_image.should == "images/descending.png"
  end

end

describe ListTickets, "view_ticket" do
  
  before(:each) do
    mock_lighthouse
    @ticket_master = mock('ticket_master', :show_tickets => nil)
    TicketMaster.stub!(:new).and_return(@ticket_master)
    @ticket = mock("ticket")    
    @lighthouse_client.stub!(:ticket).and_return(@ticket)
    # @current_project = mock("project", :id => "project_id")
    producer.production.current_project = @project
  end
  
  uses_scene :list_tickets
  
  before(:each) do
    scene.stub!(:load)
  end
    
  it "should have a view method shows a ticket" do
    scene.should_receive(:load).with("view_ticket")
    
    scene.view(4)
  end
  
  it "should get the ticket with the proper id from the project" do
    scene.view("ticket_id")
    
    scene.production.current_ticket.should == @ticket
  end
  
end

describe ListTickets, "ProjectSelector" do  
  
  before(:each) do
    mock_lighthouse
    @project.stub!(:name).and_return("One")
    @projects = [@project, mock('Project 2', :name => "Two", :open_tickets => [])]
    producer.production.current_project = @project
    @lighthouse_client.stub!(:projects).and_return(@projects)
  end

  uses_scene :list_tickets

  it "should have list of projects" do
    project_selector = scene.find("project_selector")    
    project_selector.choices.should include("One")
    project_selector.choices.should include("Two")
  end
  
end

