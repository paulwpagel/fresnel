require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "edit_ticket"

describe EditTicket do

  before(:each) do
    mock_stage_manager
    @ticket = mock('ticket')
    @edit_ticket, @scene, @production = create_player(EditTicket, 
                                                :scene => {:load => nil, :find => nil, :stage => @stage}, 
                                                :production => {:stage_manager => @stage_manager})
    @edit_ticket.id = "ticket_12345"     
    @edit_ticket.stub!(:remove_all)
    @edit_ticket.stub!(:build)    
    @edit_ticket.stub!(:hover_style).and_return(mock('hover', :background_color= => nil))        
  end

  it "should use the stage name to get the stage_info" do
    @stage_manager.should_receive(:[]).with("stage name").at_least(1).times.and_return(@stage_info)
    
    @edit_ticket.edit
  end

  it "should use the stage name to get the lighthouse_client" do
    @stage_manager.should_receive(:client_for_stage).with("stage name").at_least(1).times.and_return(@lighthouse_client)
    
    @edit_ticket.edit
  end
  
  it "should set the current ticket" do
    @lighthouse_client.should_receive(:ticket).with(12345, @project).at_least(1).times.and_return(@current_ticket)
    @stage_info.should_receive(:current_ticket=).with(@current_ticket)
    
    @edit_ticket.edit
  end
  
  it "should remove all children" do
    @edit_ticket.should_receive(:remove_all)
    
    @edit_ticket.edit
  end
  
  it "should build the edit ticket screen" do
    @lighthouse_client.stub!(:ticket).and_return(@current_ticket)
    @edit_ticket.should_receive(:build).with(:ticket => @current_ticket, :project => @project).at_least(1).times
    
    @edit_ticket.edit
  end
  
  it "should set the background color" do
    hover_style = mock('hover style')
    @edit_ticket.should_receive(:hover_style).and_return(hover_style)
    hover_style.should_receive(:background_color=).with("5A9ECF")

    @edit_ticket.edit
  end
  
end

