require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "lighthouse_client"

describe LighthouseClient do
  
  before(:each) do
    @client = LighthouseClient.new
    @client.stub!(:authenticate)
  end
  
  it "should login the user to the account" do
    Lighthouse.should_receive(:account=).with("AFlight")
    Lighthouse.should_receive(:authenticate).with("paul", "nottelling")
    
    @client.login_to("AFlight", "paul", "nottelling")
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
    options = {:title => "Test title"}
    Lighthouse::Ticket.should_receive(:new).with(:project_id => 2).and_return(ticket)
    ticket.should_receive(:title=).with("Test title")
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
end
