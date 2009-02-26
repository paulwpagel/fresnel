require File.dirname(__FILE__) + '/../spec_helper'
require 'cancel_save_ticket'

describe CancelSaveTicket do
  before(:each) do
    mock_lighthouse
     @project.stub!(:user_names).and_return(["Some User", "Roger", "Eric"])
     @project.stub!(:all_states).and_return(["new", "open", "resolved", "hold", "invalid"])
     @project.stub!(:milestone_titles).and_return(["Goal One", "Goal Two"])
     @project.stub!(:milestone_title).and_return("Goal Two")

     attribute_one = mock("changed_attribute", :name => "Name", :old_value => "Old Value", :new_value => "New Value")    
     version_one = mock("version", :comment => "Comment One", :created_by => "Version User One", :timestamp => "Time One", :changed_attributes => [attribute_one])
     version_two = mock("version", :comment => "Comment Two", :created_by => "Version User Two", :timestamp => "Time Two", :changed_attributes => [attribute_one])
     versions = [version_one, version_two]

     @ticket = mock("ticket", :id => 12345, :title => "Title", :null_object => true, :assigned_user_name => "Roger", :state => "open",
                              :description => "Some Description", :versions => versions, :milestone_id => 12345, :tag => "one two three")
     @lighthouse_client.stub!(:ticket).and_return(@ticket)
     @project.stub!(:open_tickets).and_return([@ticket])
     producer.production.current_project = @project
     producer.production.current_ticket = nil
  end
  
  uses_scene :list_tickets
  
  it "should load up the ticket list" do
    click_ticket
    ticket_master = mock('ticket_master')
    TicketMaster.should_receive(:new).and_return(ticket_master)
    
    ticket_master.should_receive(:show_tickets).with("Open Tickets")
    
    scene.find("cancel_save_button").button_pressed(nil)
  end
  
  def click_ticket
    scene.find("ticket_12345").mouse_clicked(nil)
  end
  
end