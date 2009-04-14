require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "create_ticket"

describe CreateTicket do
  before(:each) do
    mock_stage_manager
    @create_ticket, @scene, @production = create_player(CreateTicket, 
                                                :scene => {:stage => @stage, :load => nil, :find => nil}, 
                                                :production => {:stage_manager => @stage_manager})
    @create_ticket.add_ticket_group.stub!(:build)
  end
    
  it "should use the stage name to get the appropriate client" do
    @stage_manager.should_receive(:[]).with("stage name").at_least(1).times.and_return(@stage_info)

    @create_ticket.create_ticket
  end
  
  it "should call build on the add_ticket_group" do
    @create_ticket.add_ticket_group.should_receive(:build)
    
    @create_ticket.create_ticket
  end
end
