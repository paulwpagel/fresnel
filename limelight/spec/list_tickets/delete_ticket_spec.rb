require File.dirname(__FILE__) + '/../spec_helper'
require "delete_ticket"

describe DeleteTicket do
  before(:each) do
    mock_stage_manager
    @delete_ticket, @scene, @production = create_player(DeleteTicket, 
                                                :scene => {:stage => @stage, :build => nil, :load => nil, :find => nil}, 
                                                :production => {:stage_manager => @stage_manager})

    @delete_ticket.id = "12345"
  end
    
  it "should use the stage name to get the appropriate client" do
    @stage_manager.should_receive(:[]).with("stage name").and_return(@stage_info)

    @delete_ticket.delete
  end

  it "should include the ticket's title" do
    
    @project.should_receive(:ticket_title).with(12345).and_return("Ticket Title")
    @scene.should_receive(:build).with({:ticket_id => 12345, :ticket_title => "Ticket Title"})
    
    
    @delete_ticket.delete
  end
  
end