require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe Lighthouse::Memory::Project do
  before(:each) do
    @project = Lighthouse::Memory::Project.new
    @ticket1 = Lighthouse::Memory::Ticket.new(:status => "state:new")
    @ticket2 = Lighthouse::Memory::Ticket.new(:status => "state:open")
    @project.tickets << @ticket1 << @ticket2
  end
  
  it "should list all open tickets" do
    @project.open_tickets.should == [@ticket2]
  end
  
  it "should list all tickets" do
    @project.all_tickets.should == [@ticket1, @ticket2]
  end
  
  it "should have milestones" do
    @project.milestones.should == []
  end
end