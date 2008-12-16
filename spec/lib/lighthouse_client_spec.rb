require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "lighthouse_client"

describe LighthouseClient do
  
  before(:each) do
    @client = LighthouseClient.new
  end

  it "should not log in the user to the account" do
    Lighthouse.should_receive(:account=).with("AFlight")
    Lighthouse.should_receive(:authenticate).with("paul", "nottelling")
    Lighthouse::Project.should_receive(:find).with(:all).and_return([])
    
    @client.login_to("AFlight", "paul", "nottelling").should be(true)
  end
  
  it "should not log in the user to the account" do
    Lighthouse.should_receive(:account=).with("AFlight")
    Lighthouse.should_receive(:authenticate).with("paul", "nottelling")
    Lighthouse::Project.should_receive(:find).with(:all).and_raise(ActiveResource::UnauthorizedAccess.new(mock('unauthorized', :code => "401 Not Authorized")))
    
    @client.login_to("AFlight", "paul", "nottelling").should be(false)
  end
  
  it "should find a project by name" do
    project = mock(Lighthouse::Project, :name => "one")
    project2 = mock(Lighthouse::Project, :name => "two")
    Lighthouse::Project.should_receive(:find).with(:all).and_return([project, project2])

    @client.find_project("one").should == project
  end
  
  it "should return nil if there is no project" do
    Lighthouse::Project.should_receive(:find).with(:all).and_return([])

    @client.find_project("one").should be(nil)
  end
  
  it "should add a ticket to the project" do
    ticket = mock(Lighthouse::Ticket)
    options = {:title => "Test title", :description => "description"}
    Lighthouse::Ticket.should_receive(:new).with(:project_id => 2).and_return(ticket)
    ticket.should_receive(:title=).with("Test title")
    ticket.should_receive(:body=).with("description")
    ticket.should_receive(:body_html=).with("description")
    ticket.should_receive(:save)
    
    @client.add_ticket(options, 2)
  end
  
  it "should get milestones for the project" do
    milestones = [mock("milestone")]
    project = mock(Lighthouse::Project, :name => "one", :milestones => milestones)
    Lighthouse::Project.stub!(:find).and_return([project])
    
    @client.milestones("one").should == milestones
  end
  
  it "should return no milestones if there is no project" do
    Lighthouse::Project.stub!(:find).and_return([])

    @client.milestones("one").should == []
  end
  
  it "should return the milestone title for a given project and ticket" do
    milestones = [mock("milestone", :id => 123, :title => "Milestone Title")]
    project = mock(Lighthouse::Project, :name => "project one", :milestones => milestones)
    Lighthouse::Project.stub!(:find).and_return([project])
    
    @client.milestone_title("project one", 123).should == "Milestone Title"
  end
  
  it "should work if there are no milestones matching the id given" do
    project = mock(Lighthouse::Project, :name => "project one", :milestones => [])
    Lighthouse::Project.stub!(:find).and_return([project])
    
    @client.milestone_title("project one", 123).should == ""
  end
  
  it "should work if the project doesn't exist" do
    Lighthouse::Project.stub!(:find).and_return([])
    
    @client.milestone_title("project one", 123).should == ""
  end
  
  it "should get a ticket from a ticket_id through the lighthouse api" do
    Lighthouse::Ticket.should_receive(:find).with("ticket_id", :params => {:project_id => 21095})

    @client.ticket("ticket_id")
  end
  
  it "should return the found ticket" do
    ticket = mock("ticket")
    Lighthouse::Ticket.stub!(:find).and_return(ticket)
    
    @client.ticket(1).should == ticket
  end
  
end
