require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "create_ticket"

describe CreateTicket do
  before(:each) do
    @project = mock('project', :milestone_titles => [], :user_names => [])
    @create_ticket, @scene, @production = create_player(CreateTicket, 
                                                :scene => {:load => nil, :find => nil}, 
                                                :production => {:current_project => @project})
    @create_ticket.add_ticket_group.stub!(:build)
    @create_ticket.add_ticket_milestone.stub!(:choices=)
    @create_ticket.add_ticket_responsible_person.stub!(:choices=)
  end
  
  it "should call build on the add_ticket_group" do
    @create_ticket.add_ticket_group.should_receive(:build)
    
    @create_ticket.create_ticket
  end
  
  it "should populate milestones" do
    @project.should_receive(:milestone_titles).and_return(["Mile"])
    @create_ticket.add_ticket_milestone.should_receive(:choices=).with(["None", "Mile"])
    
    @create_ticket.create_ticket
  end
  
  it "should populate responsible person" do
    @project.should_receive(:user_names).and_return(["John"])
    @create_ticket.add_ticket_responsible_person.should_receive(:choices=).with(["None", "John"])
    
    @create_ticket.create_ticket
  end
end
