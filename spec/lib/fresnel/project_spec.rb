require File.dirname(__FILE__) + '/../../spec_helper'
require "fresnel/project"

describe Fresnel::Project, "tickets" do
  before(:each) do
    @lighthoust_project = mock("Lighthouse::Project", :id => 12345, :milestones => [])
    @fresnel_project = Fresnel::Project.new(@lighthoust_project)
    @tickets = [mock("ticket")]
    Lighthouse::Ticket.stub!(:find).and_return(@tickets)
  end
  
  it "should accept a project on init" do
    @fresnel_project = Fresnel::Project.new(@lighthoust_project)
  end
  
  it "should find all open tickets for a project" do
    Lighthouse::Ticket.should_receive(:find).with(:all, :params => {:project_id => 12345, :q => "state:open"})
    
    @fresnel_project.open_tickets
  end
  
  it "should return the tickets" do
    @fresnel_project.open_tickets.should == @tickets    
  end
  
  it "should find all tickets for a project" do
    Lighthouse::Ticket.should_receive(:find).with(:all, :params => {:project_id => 12345, :q => "all"})
    
    @fresnel_project.all_tickets
  end
  
  it "should return the tickets" do
    @fresnel_project.all_tickets.should == @tickets    
  end
  
end

describe Fresnel::Project, "milestones" do
  before(:each) do
    milestone_one = mock("milestone", :title => "Goal One")
    @milestones = [milestone_one]
    @lighthoust_project = mock("Lighthouse::Project", :id => nil, :milestones => @milestones)
    @fresnel_project = Fresnel::Project.new(@lighthoust_project)
  end
  
  it "should have a title for one milestone" do    
    @fresnel_project.milestone_titles.should == ["Goal One"]
  end
  
  it "should have a title for two milestones" do
    milestone_two = mock("milestone", :title => "Goal Two")
    @milestones << milestone_two
    
    @fresnel_project.milestone_titles.should == ["Goal One", "Goal Two"]
  end
end