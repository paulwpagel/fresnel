require File.dirname(__FILE__) + '/../spec_helper'
require 'list_tickets'

describe ListTickets do

  before(:each) do
    mock_stage_manager
    @lighthouse_client.stub!(:project_names).and_return(["One", "Two", "Current Project Name"])
    @style = mock('style', :background_image= => nil)
    @list_tickets, @scene, @production = create_player(ListTickets, 
                                                :scene => {:load => nil, :find => nil, :stage => @stage}, 
                                                :production => {:stage_manager => @stage_manager})

    @list_tickets.age_image.stub!(:style).and_return(@style)
    @list_tickets.project_selector.stub!(:choices=)
    @list_tickets.project_selector.stub!(:value=)
    @list_tickets.tag_lister.stub!(:show_project_tags)
    @list_tickets.ticket_lister.stub!(:filter_by_type)
  end
  
  it "should find the age image" do
    @list_tickets.age_image.should_receive(:style).and_return(@style)
    @style.should_receive(:background_image=).with("images/descending.png")
    
    @list_tickets.list
  end
    
  it "should filter by type" do
    @list_tickets.ticket_lister.should_receive(:filter_by_type).with("Open Tickets")

    @list_tickets.list
  end

  it "should show the tags for a project" do
    @list_tickets.tag_lister.should_receive(:show_project_tags)

    @list_tickets.list
  end

  it "should return the same ticket_master each time" do
    ticket_master = @list_tickets.ticket_master
    
    @list_tickets.ticket_master.should == ticket_master
  end
  
  it "should set the value of the project choices to the retrieved project name" do
    @project.stub!(:name).and_return("Current Project Name")
    @list_tickets.project_selector.should_receive(:value=).with("Current Project Name")
    
    @list_tickets.list
  end
  
  it "should have list of projects" do
    @stage_manager.should_receive(:[]).with("stage name").at_least(1).times.and_return(@stage_info)
    @list_tickets.project_selector.should_receive(:choices=).with(["One", "Two", "Current Project Name"])
    
    @list_tickets.list
  end
  
end
