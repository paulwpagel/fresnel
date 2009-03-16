require File.dirname(__FILE__) + '/../spec_helper'
require "delete_ticket"

describe DeleteTicket do
  before(:each) do
    @project = mock('project')
    @delete_ticket, @scene, @production = create_player(DeleteTicket, 
                                                :scene => {:load => nil, :find => nil}, 
                                                :production => {:current_project => @project})

  end
  
  it "should include the ticket's title" do
    @delete_ticket.id = "12345"
    
    @project.should_receive(:ticket_title).with(12345).and_return("Ticket Title")
    @scene.should_receive(:build).with({:ticket_id => 12345, :ticket_title => "Ticket Title"})
    
    
    @delete_ticket.delete
  end
  
end