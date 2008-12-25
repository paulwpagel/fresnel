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
  
  it "should find a project by name" do
    project = mock(Lighthouse::Project, :name => "one")
    project2 = mock(Lighthouse::Project, :name => "two")
    Lighthouse::Project.should_receive(:find).with(:all).and_return([project, project2])

    Lighthouse::LighthouseApi::find_project("one").should == project
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
    project = mock(Lighthouse::Project, :name => "one", :milestones => milestones)
    Lighthouse::Project.stub!(:find).and_return([project])
    
    Lighthouse::LighthouseApi::milestones("one").should == milestones
  end
  
  it "should return no milestones if there is no project" do
    Lighthouse::Project.stub!(:find).and_return([])

    Lighthouse::LighthouseApi::milestones("one").should == []
  end
  
  it "should return the milestone title for a given project and ticket" do
    milestones = [mock("milestone", :id => 123, :title => "Milestone Title")]
    project = mock(Lighthouse::Project, :name => "project one", :milestones => milestones)
    Lighthouse::Project.stub!(:find).and_return([project])
    
    Lighthouse::LighthouseApi::milestone_title("project one", 123).should == "Milestone Title"
  end
  
  it "should work if there are no milestones matching the id given" do
    project = mock(Lighthouse::Project, :name => "project one", :milestones => [])
    Lighthouse::Project.stub!(:find).and_return([project])
    
    Lighthouse::LighthouseApi::milestone_title("project one", 123).should == ""
  end
  
  it "should work if the project doesn't exist" do
    Lighthouse::Project.stub!(:find).and_return([])
    
    Lighthouse::LighthouseApi::milestone_title("project one", 123).should == ""
  end
  
  it "should get a ticket from a ticket_id through the lighthouse api" do
    Lighthouse::Ticket.should_receive(:find).with("ticket_id", :params => {:project_id => 21095})

    Lighthouse::LighthouseApi::ticket("ticket_id")
  end
  
  it "should return the found ticket" do
    ticket = mock("ticket")
    Lighthouse::Ticket.stub!(:find).and_return(ticket)
    
    Lighthouse::LighthouseApi::ticket(1).should == ticket
  end
  
end
