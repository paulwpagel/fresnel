require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "save_ticket"

describe SaveTicket do
  
  before(:each) do
    mock_stage_manager
    @ticket = mock('ticket', :null_object => true, :id => nil)
    @save_ticket, @scene, @production = create_player(SaveTicket, 
                                                :scene => {:load => nil, :find => nil, :stage => @stage},
                                                :production => {:stage_manager => @stage_manager, :current_ticket => @ticket, :current_ticket= => nil, :current_project => @project})
    @save_ticket.ticket_lister.stub!(:show_these_tickets)
  end
  
  it "should set the ticket's title" do
    @save_ticket.ticket_title.should_receive(:text).and_return("New Title")
    @production.current_ticket.should_receive(:title=).with("New Title")
   
    @save_ticket.save_ticket
  end
  
  it "should set the ticket's state" do
    @save_ticket.ticket_state.should_receive(:value).and_return("open")
    @production.current_ticket.should_receive(:state=).with("open")
   
    @save_ticket.save_ticket
  end
  
  it "should set the ticket's tag" do
    @save_ticket.ticket_tag.should_receive(:text).and_return("one two")
    @production.current_ticket.should_receive(:tag=).with("one two")
   
    @save_ticket.save_ticket
  end

  it "should get the milestone id from its title" do
    @save_ticket.ticket_milestone.should_receive(:value).and_return("Some Milestone")
    @production.current_project.should_receive(:milestone_id).with("Some Milestone").and_return(12345)
    @production.current_ticket.should_receive(:milestone_id=).with(12345)
    
    @save_ticket.save_ticket
  end
  
  it "should set the new comment for the ticket" do
    @save_ticket.ticket_comment.should_receive(:text).and_return("Some Comment")
    @production.current_ticket.should_receive(:new_comment=).with("Some Comment")
    
    @save_ticket.save_ticket
  end

  it "should get the id for the new assigned user" do
    @save_ticket.ticket_assigned_user.should_receive(:value).and_return("User Two")
    @project.should_receive(:user_id).with("User Two").and_return(9876)
    @production.current_ticket.should_receive(:assigned_user_id=).with(9876)
    
    @save_ticket.save_ticket
  end

  it "should save the ticket" do
    @production.current_ticket.should_receive(:save)
    
    @save_ticket.save_ticket
  end
  
  it "should use the stage name to get the appropriate client" do
    @stage_manager.should_receive(:[]).with("stage name").and_return(@stage_info)
    
    @save_ticket.save_ticket
  end

  it "should re-find the ticket" do
    @ticket.should_receive(:id).and_return(12345)
    @lighthouse_client.should_receive(:ticket).with(12345, @project).and_return(@ticket)
    @production.should_receive(:current_ticket=).with(@ticket)
    
    @save_ticket.save_ticket
  end

  it "should refresh the list of tickets after it saves the ticket" do
    @ticket.should_receive(:save).ordered
    @project.should_receive(:open_tickets).and_return(["ticket1", "ticket2"])
    @save_ticket.ticket_lister.should_receive(:show_these_tickets).with(["ticket1", "ticket2"]).ordered
    
    @save_ticket.save_ticket
  end
    
end

describe SaveTicket, "stub event calls" do
  class TestSaveTicket
    include SaveTicket
  end
  it "should capture mouse_clicked" do
    TestSaveTicket.new.respond_to?(:mouse_clicked).should be(true)
  end
end