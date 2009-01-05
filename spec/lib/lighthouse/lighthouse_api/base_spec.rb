require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")
require "lighthouse/lighthouse_api/base"

describe Lighthouse::LighthouseApi do

  it "should not log in the user to the account" do
    Lighthouse.should_receive(:account=).with("AFlight")
    Lighthouse.should_receive(:authenticate).with("paul", "nottelling")
    Lighthouse::Project.should_receive(:find).with(:all).and_return([])
    
    Lighthouse::LighthouseApi::login_to("AFlight", "paul", "nottelling").should be(true)
  end
  
  it "should not log in the user to the account" do
    Lighthouse.should_receive(:account=).with("AFlight")
    Lighthouse.should_receive(:authenticate).with("paul", "nottelling")
    Lighthouse::Project.should_receive(:find).with(:all).and_raise(ActiveResource::UnauthorizedAccess.new(mock('unauthorized', :code => "401 Not Authorized")))
    
    Lighthouse::LighthouseApi::login_to("AFlight", "paul", "nottelling").should be(false)
  end
  
  it "should error if there is no account name" do
    Lighthouse.should_receive(:account=).with("AFlight")
    Lighthouse.should_receive(:authenticate).with("paul", "nottelling")
    
    Lighthouse::Project.should_receive(:find).with(:all).and_raise(ActiveResource::ResourceNotFound.new(mock('not found', :code => "Not Found")))

    Lighthouse::LighthouseApi::login_to("AFlight", "paul", "nottelling").should be(false)  
  end
  
  it "should return nil if there is no project" do    
    Lighthouse::Project.should_receive(:find).with(:all).and_return([])

    Lighthouse::LighthouseApi::find_project("one").should be(nil)
  end
  
  it "should add a ticket to the project" do
    @project = mock(Lighthouse::Project, :id => 2)
    Lighthouse::LighthouseApi.should_receive(:find_project).with("fresnel").and_return(@project)
    ticket = mock(Lighthouse::Ticket)
    options = {:title => "Test title", :description => "description"}
    Lighthouse::Ticket.should_receive(:new).with(:project_id => 2).and_return(ticket)
    ticket.should_receive(:title=).with("Test title")
    ticket.should_receive(:body=).with("description")
    ticket.should_receive(:body_html=).with("description")
    ticket.should_receive(:save)
    
    Lighthouse::LighthouseApi::add_ticket(options, "fresnel")
  end
  
  it "should get milestones for the project" do
    milestones = [mock("milestone")]
    project = mock(Lighthouse::Project, :name => "one", :milestones => milestones, :id => nil)
    Lighthouse::Project.stub!(:find).and_return([project])
    
    Lighthouse::LighthouseApi::milestones("one").should == milestones
  end
  
  it "should return no milestones if there is no project" do
    Lighthouse::Project.stub!(:find).and_return([])

    Lighthouse::LighthouseApi::milestones("one").should == []
  end
  
  it "should return the milestone title for a given project and ticket" do
    milestones = [mock("milestone", :id => 123, :title => "Milestone Title")]
    project = mock(Lighthouse::Project, :name => "project one", :milestones => milestones, :id => nil)
    Lighthouse::Project.stub!(:find).and_return([project])
    
    Lighthouse::LighthouseApi::milestone_title("project one", 123).should == "Milestone Title"
  end
  
  it "should work if there are no milestones matching the id given" do
    project = mock(Lighthouse::Project, :name => "project one", :milestones => [], :id => nil)
    Lighthouse::Project.stub!(:find).and_return([project])
    
    Lighthouse::LighthouseApi::milestone_title("project one", 123).should == ""
  end
  
  it "should work if the project doesn't exist" do
    Lighthouse::Project.stub!(:find).and_return([])
    
    Lighthouse::LighthouseApi::milestone_title("project one", 123).should == ""
  end
  
end

describe "ticket" do
  before(:each) do
    @ticket = mock("ticket")
    Lighthouse::Ticket.stub!(:find).and_return(@ticket)
    @fresnel_ticket = mock(Fresnel::Ticket)
    Fresnel::Ticket.stub!(:new).and_return(@fresnel_ticket)
  end
  
  it "should get a ticket from a ticket and project id through the lighthouse api" do
    Lighthouse::Ticket.should_receive(:find).with("ticket_id", :params => {:project_id => "project_id"}).and_return(@ticket)

    Lighthouse::LighthouseApi::ticket("ticket_id", "project_id")
  end
  
  it "should make a fresnel ticket from the found ticket" do
    Fresnel::Ticket.should_receive(:new).with(@ticket, "project_id")
    
    Lighthouse::LighthouseApi::ticket(1, "project_id")
  end
  
  it "should return the fresnel ticket" do
    Lighthouse::LighthouseApi::ticket(1, 2).should == @fresnel_ticket
  end
  
  it "should return nil if it cannot find the lighthouse ticket" do
    Lighthouse::Ticket.stub!(:find).and_return(nil)
    
    Lighthouse::LighthouseApi::ticket(1, 2).should be_nil
  end
end

describe Lighthouse::LighthouseApi, "find_project" do
  before(:each) do
    @project1 = mock(Lighthouse::Project, :name => "one")
    @project2 = mock(Lighthouse::Project, :name => "two")
    Lighthouse::Project.stub!(:find).and_return([@project1, @project2])
    @fresnel_project = mock(Lighthouse::LighthouseApi::Project)
    Lighthouse::LighthouseApi::Project.stub!(:new).and_return(@fresnel_project)
  end
  
  it "should find all projects" do
    Lighthouse::Project.should_receive(:find).with(:all).and_return([])

    Lighthouse::LighthouseApi::find_project("anything")
  end
  
  it "should find the specific project and create a fresnel project from it " do    
    Lighthouse::LighthouseApi::Project.should_receive(:new).with(@project1)
    
    Lighthouse::LighthouseApi::find_project("one")
  end
  
  it "should return the created fresnel project" do
    Lighthouse::LighthouseApi::find_project("one").should == @fresnel_project
  end
  
  it "should get projects" do
    projects = [mock('project')]
    
    Lighthouse::Project.should_receive(:find).with(:all).and_return(projects)
    
    Lighthouse::LighthouseApi.projects.should == projects
  end
end