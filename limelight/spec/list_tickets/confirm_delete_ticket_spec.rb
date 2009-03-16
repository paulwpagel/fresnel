require File.dirname(__FILE__) + '/../spec_helper'
require "confirm_delete_ticket"

describe ConfirmDeleteTicket do
  
  before(:each) do
    @current_project = mock('project', :destroy_ticket => nil)
    @current_ticket = mock('ticket', :id => 12345)
    @confirm_delete, @scene, @production = create_player(ConfirmDeleteTicket, 
                                                :scene => {:load => nil, :find => nil, :remove => nil}, 
                                                :production => {:current_project => @current_project, :current_ticket => @current_ticket, :current_ticket= => nil})
                                                
    @confirm_delete.id = "confirm_delete_ticket_12345"
    @confirm_delete.ticket_lister.stub!(:remove_ticket)                                                
  end
  
  it "should destroy the ticket on mouse_clicked" do
    @current_project.should_receive(:destroy_ticket).with(12345)
    
    @confirm_delete.confirm_delete
  end
  
  it "should clear the ticket from the production if the current_ticket is the deleted ticket" do    
    @production.should_receive(:current_ticket=).with(nil)
    
    @confirm_delete.confirm_delete
  end
  
  it "should not clear the ticket from the production if it is not the deleted ticket" do
    different_ticket = mock("ticket", :id => 67890)
    @production.should_receive(:current_ticket).twice.and_return(different_ticket)
    @production.should_not_receive(:current_ticket=).with(nil)
    
    @confirm_delete.confirm_delete
  end
  
  it "should tell the ticket_lister to remove the ticket from the list" do    
    @confirm_delete.ticket_lister.should_receive(:remove_ticket).with(12345)
    
    @confirm_delete.confirm_delete
  end
  
  
  it "should get rid of the confirmation box" do
    @scene.should_receive(:remove).with(@confirm_delete.delete_ticket_confirmation_main)
    @confirm_delete.confirm_delete
  end
  
end