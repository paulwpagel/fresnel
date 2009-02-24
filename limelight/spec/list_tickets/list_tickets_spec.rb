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
  
  # it "should have a ticket_lister" do
  #   lister = mock('lister')
  #   @scene.should_receive(:find).with("ticket_lister").and_return(lister)
  #   
  #   @scene.ticket_lister.should == lister
  # end
  
  it "should find the age image" do
    scene.find("age_image").style.background_image.should == "images/descending.png"
  end

end

describe ListTickets, "ProjectSelector" do  
  
  before(:each) do
    mock_lighthouse
    producer.production.current_project = @project
    @lighthouse_client.stub!(:project_names).and_return(["One", "Two"])
  end

  uses_scene :list_tickets

  it "should have list of projects" do
    project_selector = scene.find("project_selector")    
    project_selector.choices.should include("One")
    project_selector.choices.should include("Two")
  end
  
end

describe ListTickets, "tag lister" do
  before(:each) do
    @player_under_test = Object.new
    @player_under_test.extend(ListTickets)
    @scene = mock("scene", :null_object => true)
    @player_under_test.stub!(:show_spinner).and_yield
    @player_under_test.stub!(:scene).and_return(@scene)
    @production = mock("production", :null_object => true)
    @player_under_test.stub!(:production).and_return(@production)
  end
    
  it "should show the projects tags when the scene is opened" do
    tag_lister = mock("tag_lister")
    @scene.stub!(:tag_lister).and_return(tag_lister)
    
    tag_lister.should_receive(:show_project_tags)
    
    @player_under_test.scene_opened(nil)
  end
    
end