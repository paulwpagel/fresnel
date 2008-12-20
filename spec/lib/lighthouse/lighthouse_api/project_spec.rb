require File.dirname(__FILE__) + '/../../../spec_helper'
require "lighthouse/project"

describe Lighthouse::Project do
  before(:each) do
    @project = Lighthouse::Project.new
    @project.stub!(:id).and_return(12345)
    @tickets = [mock("ticket")]
    Lighthouse::Ticket.stub!(:find).and_return(@tickets)
  end
  
  it "should find all open tickets for a project" do
    Lighthouse::Ticket.should_receive(:find).with(:all, :params => {:project_id => 12345, :q => "state:open"})
    
    @project.open_tickets
  end
  
  it "should return the tickets" do
    @project.open_tickets.should == @tickets    
  end
  
  it "should find all tickets for a project" do
    Lighthouse::Ticket.should_receive(:find).with(:all, :params => {:project_id => 12345, :q => "all"})
    
    @project.all_tickets
  end
  
  it "should return the tickets" do
    @project.all_tickets.should == @tickets    
  end
  
end