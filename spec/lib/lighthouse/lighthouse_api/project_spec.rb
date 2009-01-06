require File.dirname(__FILE__) + '/../../../spec_helper'
require "lighthouse/lighthouse_api/project"

describe Lighthouse::LighthouseApi::Project, "tickets" do
  before(:each) do
    @lighthoust_project = mock("Lighthouse::Project", :id => 12345, :milestones => [])
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthoust_project)
    @tickets = [mock("ticket")]
    Lighthouse::LighthouseApi::Ticket.stub!(:find_tickets).and_return(@tickets)
    @fresnel_tickets = [mock(Lighthouse::LighthouseApi::Ticket)]
  end
  
  it "should accept a project on init" do
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthoust_project)
  end
  
  it "should find all open tickets for a project" do
    Lighthouse::LighthouseApi::Ticket.should_receive(:find_tickets).with(12345, "state:open")
    
    @fresnel_project.open_tickets
  end
  
  it "should return the tickets" do
    @fresnel_project.open_tickets.should == @tickets    
  end
  
  it "should find all tickets for a project" do
    Lighthouse::LighthouseApi::Ticket.should_receive(:find_tickets).with(12345, "all")
    
    @fresnel_project.all_tickets
  end
  
  it "should return the tickets" do
    @fresnel_project.all_tickets.should == @tickets    
  end
  
  it "should have an id" do
    @fresnel_project.id.should == 12345
  end
end

describe Lighthouse::LighthouseApi::Project, "milestones" do
  before(:each) do
    milestone_one = mock("milestone", :title => "Goal One", :id => "id_one")
    @milestones = [milestone_one]
    @lighthoust_project = mock("Lighthouse::Project", :id => nil, :milestones => @milestones)
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthoust_project)
  end
  
  it "should return the milestones for a project" do
    @fresnel_project.milestones.should == @milestones
  end
  
  it "should have a title for one milestone" do    
    @fresnel_project.milestone_titles.should == ["Goal One"]
  end
  
  it "should have a title for two milestones" do
    milestone_two = mock("milestone", :title => "Goal Two")
    @milestones << milestone_two
    
    @fresnel_project.milestone_titles.should == ["Goal One", "Goal Two"]
  end
  
  it "should get an id from a milestone title" do
    @fresnel_project.milestone_id("Goal One").should == "id_one"
  end
  
  it "should get an id for a different mileston" do
    milestone_two = mock("milestone", :title => "Goal Two", :id => "id_two")
    @milestones << milestone_two
    
    @fresnel_project.milestone_id("Goal Two").should == "id_two"
  end
  
  it "should return nil if it cannot find the title" do
    @fresnel_project.milestone_id("Bad Title").should be_nil
  end
end

describe Lighthouse::LighthouseApi::Project, "states" do
  before(:each) do
    @lighthoust_project = mock("Lighthouse::Project", :id => nil, :milestones => [], :open_states_list => "one,two,three",
                                                      :closed_states_list => "closed_one,closed_two,closed_three")
    @fresnel_project = Lighthouse::LighthouseApi::Project.new(@lighthoust_project)
  end
  
  it "should get the open_states" do
    @fresnel_project.open_states.should == ["one", "two", "three"]
  end
  
  it "should get the closed_states" do
    @fresnel_project.closed_states.should == ["closed_one", "closed_two", "closed_three"]
  end
  
  it "should get all the states" do
    @fresnel_project.all_states.should == ["one", "two", "three", "closed_one", "closed_two", "closed_three"]
  end
end