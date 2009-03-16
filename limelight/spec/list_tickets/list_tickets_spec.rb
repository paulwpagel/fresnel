require File.dirname(__FILE__) + '/../spec_helper'
require 'list_tickets'

describe ListTickets do

  before(:each) do
    @lighthouse_client = mock('lighthouse', :project_names => [], :get_starting_project_name => "")
    @style = mock('style', :background_image= => nil)
    @list_tickets, @scene, @production = create_player(ListTickets, 
                                                :scene => {:load => nil, :find => nil}, 
                                                :production => {:lighthouse_client => @lighthouse_client})

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
  
  it "should have list of projects" do
    @lighthouse_client.should_receive(:project_names).and_return(["One", "Two"])
    @list_tickets.project_selector.should_receive(:choices=).with(["One", "Two"])
    
    @list_tickets.list
  end
  
  it "should set the value of the project" do
    @lighthouse_client.should_receive(:get_starting_project_name).and_return("Starter")
    @list_tickets.project_selector.should_receive(:value=).with("Starter")
    
    @list_tickets.list
  end
  
  it "should filter by type" do
    @list_tickets.ticket_lister.should_receive(:filter_by_type).with("Open Tickets")

    @list_tickets.list
  end

  it "should filter by type" do
    @list_tickets.tag_lister.should_receive(:show_project_tags)

    @list_tickets.list
  end

  it "should return the same ticket_master each time" do
    ticket_master = @list_tickets.ticket_master
    
    @list_tickets.ticket_master.should == ticket_master
  end
    
end
