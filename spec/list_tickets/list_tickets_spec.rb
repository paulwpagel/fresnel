require File.dirname(__FILE__) + '/../spec_helper'
require 'list_tickets'

describe ListTickets do
  before(:each) do
    @player_under_test = Object.new
    @player_under_test.extend(ListTickets)
    @ticket_master = mock('ticket_master', :show_tickets => nil)
    TicketMaster.stub!(:new).and_return(@ticket_master)
    @scene = mock('scene')
    @player_under_test.stub!(:scene).and_return(@scene)
    @lighthouse_client = mock("lighthouse_client", :projects => [])
    @player_under_test.stub!(:production).and_return(mock("production", :lighthouse_client => @lighthouse_client))
  end
  
  it "should have a ticket_master" do
    TicketMaster.should_receive(:new).with(@player_under_test).and_return(@ticket_master)
    
    @player_under_test.ticket_master.should == @ticket_master
  end
  
  it "should have a ticket_lister" do
    lister = mock('lister')
    @scene.should_receive(:find).with("ticket_lister").and_return(lister)
    
    @player_under_test.ticket_lister.should == lister
  end
  
  describe "scene_opened" do
    before(:each) do
      @style = mock("style", :background_image= => nil)
      @age_image = mock("prop", :style => @style, :choices= => nil)
      @scene.stub!(:find).and_return(@age_image)
    end
    
    it "should show the open tickets" do
      @ticket_master.should_receive(:show_tickets).with("Open Tickets")
    
      open_scene
    end
  
    it "should find the age image" do
      @scene.should_receive(:find).with("age_image").and_return(@age_image)
      
      open_scene
    end
    
    it "should set the background image of the age image" do
      @style.should_receive(:background_image=).with("images/descending.png")
      
      open_scene
    end
    
    def open_scene
      @player_under_test.scene_opened(nil)
    end
  end
end

describe ListTickets, "view_ticket" do
  
  class Production
    attr_accessor :current_ticket, :lighthouse_client, :current_project
  end
  
  before(:each) do
    @player_under_test = Object.new
    @player_under_test.extend(ListTickets)
    @scene = mock("scene", :load => nil)
    @player_under_test.stub!(:scene).and_return(@scene)

    production = Production.new
    @player_under_test.stub!(:production).and_return(production)
    
    @ticket = mock("ticket")    
    @lighthouse_client = mock("LighthouseClient", :ticket => @ticket)
    production.lighthouse_client = @lighthouse_client
    
    @current_project = mock("project", :id => "project_id")
    production.current_project = @current_project
  end
  
  it "should have a view method shows a ticket" do
    @scene.should_receive(:load).with("view_ticket")
    
    @player_under_test.view(4)
  end
  
  it "should find the ticket with an id on view" do
    @lighthouse_client.should_receive(:ticket).with(1234, @current_project)
    
    @player_under_test.view(1234)
  end
  
  it "should get the ticket with the proper id from the project" do
    @player_under_test.view("ticket_id")
    
    @player_under_test.production.current_ticket.should == @ticket
  end
  
end


describe ListTickets, "ProjectSelector" do  
  
  before(:each) do
    mock_lighthouse
    @project1 = mock('Project', :name => "One", :open_tickets => [])
    @projects = [@project1, mock('Project 2', :name => "Two", :open_tickets => [])]
    producer.production.current_project = @project1
    @lighthouse_client.stub!(:projects).and_return(@projects)
  end

  uses_scene :list_tickets

  it "should have list of projects" do
    project_selector = scene.find("project_selector")    
    project_selector.choices.should include("One")
    project_selector.choices.should include("Two")
  end
  
end

