require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
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
  
  it "should not log in the user if the account is empty" do
    Lighthouse.should_receive(:account=).and_raise(URI::InvalidURIError)
    
    Lighthouse::LighthouseApi::login_to("", "paul", "nottelling").should be(false)  
  end
  
  it "should return nil if there is no project" do    
    Lighthouse::Project.should_receive(:find).with(:all).and_return([])

    Lighthouse::LighthouseApi::find_project("one").should be(nil)
  end
  
  it "should add a ticket to the project" do
    @project = mock(Lighthouse::Project, :id => 2)
    ticket = mock(Lighthouse::Ticket)
    options = {:title => "Test title", :description => "description", :assigned_user_id => 456, :tag => "fake tag", :milestone_id => 12345}
    Lighthouse::Ticket.should_receive(:new).with(:project_id => 2).and_return(ticket)
    ticket.should_receive(:title=).with("Test title")
    ticket.should_receive(:body=).with("description")
    ticket.should_receive(:body_html=).with("description")
    ticket.should_receive(:assigned_user_id=).with(456)
    ticket.should_receive(:tag=).with("fake tag")
    ticket.should_receive(:milestone_id=).with(12345)
    ticket.should_receive(:save)
    
    Lighthouse::LighthouseApi::add_ticket(options, @project)
  end
  
  it "should return the account" do
    Lighthouse.should_receive(:account).and_return("Some Account")
    
    Lighthouse::LighthouseApi.account.should == "Some Account"
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
  
  it "should add a project" do
    @project = mock(Lighthouse::Project)
    Lighthouse::Project.should_receive(:new).and_return(@project)
    @project.should_receive(:name=).with("project_name")
    @project.should_receive(:public=).with("true")
    @project.should_receive(:save)
    
    Lighthouse::LighthouseApi::add_project({:name => "project_name", :public => "true"})
  end
  
  it "should return the first project as a LighthouseApi project" do
    Lighthouse::LighthouseApi::Project.should_receive(:new).with(@project1).and_return(@fresnel_project)
    
    Lighthouse::LighthouseApi.first_project.should == @fresnel_project
  end
  
  it "should get project_names" do
    Lighthouse::Project.stub!(:find).and_return([@project1, @project2])
    
    Lighthouse::LighthouseApi.project_names.size.should == 2
    Lighthouse::LighthouseApi.project_names.should include("one")
    Lighthouse::LighthouseApi.project_names.should include("two")
  end
end

describe Lighthouse::LighthouseApi, "get starting project" do
  it "should get the starting project" do
    chooser = mock("FirstProjectChooser")
    Lighthouse::LighthouseApi::FirstProjectChooser.stub!(:new).and_return(chooser)
    chooser.should_receive(:get_project_name).and_return("Project One")
    
    Lighthouse::LighthouseApi.get_starting_project_name.should == "Project One"
  end
end