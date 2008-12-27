require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")


describe Lighthouse::Memory::Ticket do
  it "should have basic information" do
    options = {:title => "title", :status => "state:open", :milestone_id => 2, :id => 200 }
    ticket = Lighthouse::Memory::Ticket.new(options)
    ticket.title.should == "title"
    ticket.status.should == "state:open"
    ticket.id.should == 200
  end
  
  it "should get the milestone from the project" do
    milestone = Lighthouse::Memory::Milestone.new(:title => "completion", :id => 2)
    ticket = Lighthouse::Memory::Ticket.new({:title => "title", :status => "state:open", :milestone_id => milestone.id })
    project = Lighthouse::Memory::Project.new(:name => "test_project")
    project.milestones << milestone
    
    ticket.milestone(project).should == milestone
  end
  
end