require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")
require "lighthouse/lighthouse_api/base"

describe Lighthouse::LighthouseApi do

  before(:each) do
    @mock_project = mock("project")
    Lighthouse::LighthouseApi::Project.stub!(:new).and_return(@mock_project)
    project = mock(Lighthouse::Project, :name => "one", :id => nil)
    Lighthouse::Project.stub!(:find).and_return([project])
  end
  
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
    ticket = mock(Lighthouse::Ticket)
    options = {:title => "Test title", :description => "description"}
    Lighthouse::Ticket.should_receive(:new).with(:project_id => 2).and_return(ticket)
    ticket.should_receive(:title=).with("Test title")
    ticket.should_receive(:body=).with("description")
    ticket.should_receive(:body_html=).with("description")
    ticket.should_receive(:save)
    
    Lighthouse::LighthouseApi::add_ticket(options, @project)
  end
  
  it "should get milestones for the project" do
    milestones = [mock("milestone")]
    @mock_project.stub!(:milestones).and_return(milestones)
    
    Lighthouse::LighthouseApi::milestones("one").should == milestones
  end
  
  it "should return no milestones if there is no project" do
    Lighthouse::Project.stub!(:find).and_return([])

    Lighthouse::LighthouseApi::milestones("one").should == []
  end
  
  it "should return the milestone title for a given project and ticket" do
    milestones = [mock("milestone", :id => 123, :title => "Milestone Title")]
    project = mock(Lighthouse::Project, :name => "project one", :id => nil)
    Lighthouse::Project.stub!(:find).and_return([project])
    @mock_project.stub!(:milestones).and_return(milestones)
    
    Lighthouse::LighthouseApi::milestone_title("project one", 123).should == "Milestone Title"
  end
  
  it "should not crash if there are no milestones matching the id given" do
    @mock_project.stub!(:milestones).and_return([])

    Lighthouse::LighthouseApi::milestone_title("project one", 123).should == ""
  end
  
  it "should work if the project doesn't exist" do
    Lighthouse::Project.stub!(:find).and_return([])
    
    Lighthouse::LighthouseApi::milestone_title("project one", 123).should == ""
  end
  
  it "should get all users for a project" do
    @project = mock(Lighthouse::Project, :id => 2)
    @user = mock(Lighthouse::User, :name => "Paul")

    Lighthouse::User.should_receive(:find).with(1234).and_return(@user)
    @project.should_receive(:users).and_return([mock(Lighthouse::ProjectMembership, :id => 1234)])
    
    Lighthouse::LighthouseApi::users_for_project(@project)
  end
  
end

describe "ticket" do
  before(:each) do
    @ticket = mock("ticket")
    Lighthouse::Ticket.stub!(:find).and_return(@ticket)
    @fresnel_ticket = mock(Lighthouse::LighthouseApi::Ticket)
    @project = mock("project", :id => "project_id")
    Lighthouse::LighthouseApi::Ticket.stub!(:new).and_return(@fresnel_ticket)
  end
  
  it "should get a ticket from a ticket and project id through the lighthouse api" do
    Lighthouse::Ticket.should_receive(:find).with("ticket_id", :params => {:project_id => "project_id"}).and_return(@ticket)

    Lighthouse::LighthouseApi::ticket("ticket_id", @project)
  end
  
  it "should make a fresnel ticket from the found ticket" do
    Lighthouse::LighthouseApi::Ticket.should_receive(:new).with(@ticket, @project)
    
    Lighthouse::LighthouseApi::ticket(1, @project)
  end
  
  it "should return the fresnel ticket" do
    Lighthouse::LighthouseApi::ticket(1, @project).should == @fresnel_ticket
  end
  
  it "should return nil if it cannot find the lighthouse ticket" do
    Lighthouse::Ticket.stub!(:find).and_return(nil)
    
    Lighthouse::LighthouseApi::ticket(1, @project).should be_nil
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