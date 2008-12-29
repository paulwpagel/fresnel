require File.dirname(__FILE__) + '/../../../spec_helper'
require "lighthouse/project"

describe Lighthouse::Project, "tickets" do
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

describe Lighthouse::Project, "milestones" do
  before(:each) do
    @project = Lighthouse::Project.new
    milestone_one = mock("milestone", :title => "Goal One")
    @milestones = [milestone_one]
    @project.stub!(:milestones).and_return(@milestones)
  end
  
  it "should have a title for one milestone" do    
    @project.milestone_titles.should == ["Goal One"]
  end
  
  it "should have a title for two milestones" do
    milestone_two = mock("milestone", :title => "Goal Two")
    @milestones << milestone_two
    
    @project.milestone_titles.should == ["Goal One", "Goal Two"]
  end
end