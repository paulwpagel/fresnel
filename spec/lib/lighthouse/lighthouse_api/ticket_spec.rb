require File.dirname(__FILE__) + '/../../../spec_helper'
require "lighthouse/lighthouse_api/ticket"

describe Lighthouse::LighthouseApi::Ticket, "initialize" do
  before(:each) do
    @lighthouse_ticket = mock("Lighthouse::Ticket", :assigned_user_id => 123, :id => "ticket_id")
  end
  
  it "should have no versions if the given ticket has none" do
    @lighthouse_ticket.should_receive(:versions).and_raise(NoMethodError)
    
    @fresnel_ticket = Lighthouse::LighthouseApi::Ticket.new(@lighthouse_ticket, "project_id")
    
    @fresnel_ticket.versions.should == []
  end
end

describe Lighthouse::LighthouseApi::Ticket, "assigned_user" do
  before(:each) do
    @lighthouse_ticket = mock("Lighthouse::Ticket", :assigned_user_id => 123, :versions => [])
    @fresnel_ticket = Lighthouse::LighthouseApi::Ticket.new(@lighthouse_ticket, "project_id")
    @muser = mock(Lighthouse::User, :name => "Denny")
    Lighthouse::LighthouseApi::User.stub!(:find_by_id).and_return(@muser)
  end

  it "should find the assigned_user" do
    Lighthouse::LighthouseApi::User.should_receive(:find_by_id).with(123)
    
    @fresnel_ticket.assigned_user
  end
  
  it "should return the assigned_user" do    
    @fresnel_ticket.assigned_user.should == @muser
  end
  
  it "should return the assigned_user_name" do
    @fresnel_ticket.assigned_user_name.should == "Denny"
  end
  
  it "should be blank if the user isn't found" do
    Lighthouse::LighthouseApi::User.stub!(:find_by_id).and_return(nil)
    
    @fresnel_ticket.assigned_user_name.should == ''
  end
end

describe Lighthouse::LighthouseApi::Ticket, "description" do
  before(:each) do
    @version_one = mock("version", :body => "Some Description")
    @lighthouse_ticket = mock("Lighthouse::Ticket", :versions => [@version_one], :assigned_user_id => nil)
    @fresnel_ticket = Lighthouse::LighthouseApi::Ticket.new(@lighthouse_ticket, "project_id")
  end

  it "should have get the description from the first version" do
    @version_one.should_receive(:body)
    
    @fresnel_ticket.description
  end
  
  it "should return the description" do
    @fresnel_ticket.description.should == "Some Description"
  end
  
  it "should not crash if there are no versions" do
    @lighthouse_ticket.stub!(:versions).and_return([])
    @fresnel_ticket = Lighthouse::LighthouseApi::Ticket.new(@lighthouse_ticket, "project_id")
    
    @fresnel_ticket.description.should == ""
  end
end

describe Lighthouse::LighthouseApi::Ticket, "comments" do
  before(:each) do
    @version_one = mock("version", :body => "Some Description")
    @versions = [@version_one]
    @lighthouse_ticket = mock("Lighthouse::Ticket", :versions => @versions, :assigned_user_id => nil)
    @fresnel_ticket = Lighthouse::LighthouseApi::Ticket.new(@lighthouse_ticket, "project_id")
  end
  
  it "should return an array of comments ingoring the description" do
    @fresnel_ticket.comments.should == []
  end
  
  it "should give one comment" do
    version_two = mock("version", :body => "First Comment")
    @versions << version_two
    
    @fresnel_ticket.comments.should == ["First Comment"]
  end

  it "should give two comments" do
    version_two = mock("version", :body => "First Comment")
    version_three = mock("version", :body => "Second Comment")
    @versions << version_two
    @versions << version_three
    
    @fresnel_ticket.comments.should == ["First Comment", "Second Comment"]
  end
end

describe Lighthouse::LighthouseApi::Ticket, "fresnel versions" do
  before(:each) do
    @original_state = mock("original version")
    @version_one = mock("version")
    @versions = [@original_state, @version_one]
    @lighthouse_ticket = mock("Lighthouse::Ticket", :versions => @versions, :assigned_user_id => nil)
    @fresnel_ticket = Lighthouse::LighthouseApi::Ticket.new(@lighthouse_ticket, "project_id")

    @fresnel_version = mock(Lighthouse::LighthouseApi::TicketVersion)
    Lighthouse::LighthouseApi::TicketVersion.stub!(:new).and_return(@fresnel_version)
  end
  
  it "should have a fresnel version for one lighthouse version" do
    Lighthouse::LighthouseApi::TicketVersion.should_receive(:new).with(@version_one, "project_id").and_return(@fresnel_version)
    
    @fresnel_ticket.versions.should == [@fresnel_version]
  end
  
  it "should have a fresnel version for a second lighthouse version" do
    version_two = mock("version")
    @versions << version_two
    Lighthouse::LighthouseApi::TicketVersion.should_receive(:new).with(version_two, "project_id").and_return(@fresnel_version)
    
    @fresnel_ticket.versions.should == [@fresnel_version, @fresnel_version]
  end
end

describe Lighthouse::LighthouseApi::Ticket, "find" do
  before(:each) do
    @ticket_one = mock("Lighthouse::Ticket")
    @tickets = [@ticket_one]
    @fresnel_ticket = mock(Lighthouse::LighthouseApi::Ticket)
    Lighthouse::LighthouseApi::Ticket.stub!(:new).and_return(@fresnel_ticket)
    Lighthouse::Ticket.stub!(:find).and_return(@tickets)
  end
  
  it "should call find tickets with the state and project_id" do
    Lighthouse::Ticket.should_receive(:find).with(:all, :params => {:project_id => "project_id", :q => "query"}).and_return([])
    
    Lighthouse::LighthouseApi::Ticket.find_tickets("project_id", "query")
  end
  
  it "should make fresnel tickets for the first ticket found" do
    Lighthouse::LighthouseApi::Ticket.should_receive(:new).with(@ticket_one, "project_id")
    
    Lighthouse::LighthouseApi::Ticket.find_tickets("project_id", "query")
  end 
  
  it "should make fresnel tickets for the second ticket found" do
    @ticket_two = mock("Lighthouse::Ticket")
    @tickets << @ticket_two
    Lighthouse::LighthouseApi::Ticket.should_receive(:new).with(@ticket_two, "project_id")
  
    Lighthouse::LighthouseApi::Ticket.find_tickets("project_id", "query")
  end
  
  it "should return the fresnel tickets" do
    @ticket_two = mock("Lighthouse::Ticket")
    @tickets << @ticket_two
    
    Lighthouse::LighthouseApi::Ticket.find_tickets("project_id", "query").should == [@fresnel_ticket, @fresnel_ticket]
  end

end

describe Lighthouse::LighthouseApi::Ticket, "lighthouse ticket attributes" do
  before(:each) do
    @lighthouse_ticket = mock("Lighthouse::Ticket", :versions => [], :assigned_user_id => nil,
                                    :id => "ticket_id", :state => "Open", :title => "Some Title", :milestone_id => "Milestone ID")
    @fresnel_ticket = Lighthouse::LighthouseApi::Ticket.new(@lighthouse_ticket, "project_id")
  end
  
  it "should have an id" do
    @fresnel_ticket.id.should == "ticket_id"
  end
  
  it "should have a state" do
    @fresnel_ticket.state.should == "Open"
  end
  
  it "should have a title" do
    @fresnel_ticket.title.should == "Some Title"
  end
  
  it "should have a milestone_id" do
    @fresnel_ticket.milestone_id.should == "Milestone ID"
  end
  
  it "should have a project_id" do
    @fresnel_ticket.project_id.should == "project_id"
  end
  
  it "should have way to set a new comment" do
    @lighthouse_ticket.should_receive(:body=).with("new comment")
    
    @fresnel_ticket.new_comment = "new comment"
  end
end

describe Lighthouse::LighthouseApi::Ticket, "editing" do
  before(:each) do
    @lighthouse_ticket = mock("Lighthouse::Ticket", :versions => @versions, :assigned_user_id => nil)
    @fresnel_ticket = Lighthouse::LighthouseApi::Ticket.new(@lighthouse_ticket, "project_id")
  end
  
  it "should have a save method" do
    @lighthouse_ticket.should_receive(:save)
    
    @fresnel_ticket.save
  end
  
  it "should have a way to set the milestone_id" do
    @lighthouse_ticket.should_receive(:milestone_id=).with(12345)
    
    @fresnel_ticket.milestone_id = 12345
  end
  
  it "should have a way to set the title" do
    @lighthouse_ticket.should_receive(:title=).with("New Title")
    
    @fresnel_ticket.title = "New Title"
  end
end

describe Lighthouse::LighthouseApi::Ticket, "changed attributes" do
  before(:each) do
    lighthouse_version = mock("lighthouse_version")
    @versions = [lighthouse_version, lighthouse_version, lighthouse_version, lighthouse_version]
    @fresnel_version = mock('fresnel_version')
    Lighthouse::LighthouseApi::TicketVersion.stub!(:new).and_return(@fresnel_version)
    @lighthouse_ticket = mock("Lighthouse::Ticket", :versions => @versions, :assigned_user_id => nil)
    @fresnel_ticket = Lighthouse::LighthouseApi::Ticket.new(@lighthouse_ticket, "project_id")    
    @changed_attributes_list = mock('changed_attributes_list')
    @changed_attributes = mock("changed_attributes", :list => @changed_attributes_list)
    Lighthouse::LighthouseApi::ChangedAttributes.stub!(:new).and_return(@changed_attributes)
  end
  
  it "should create a changed attributes with the versions from the given one" do
    Lighthouse::LighthouseApi::ChangedAttributes.should_receive(:new).with([@fresnel_version, @fresnel_version], @fresnel_ticket).and_return(@changed_attributes)
    
    @fresnel_ticket.changed_attributes_for_version(1)
  end
  
  it "should return the list ofchanged_attributes" do    
    @fresnel_ticket.changed_attributes_for_version(1).should == @changed_attributes_list
  end
end

describe Lighthouse::LighthouseApi::Ticket, "milestone_title" do
  before(:each) do
    @lighthouse_ticket = mock("Lighthouse::Ticket", :versions => [], :assigned_user_id => nil, :milestone_id => "Milestone ID")
    @fresnel_ticket = Lighthouse::LighthouseApi::Ticket.new(@lighthouse_ticket, "project_id")
    @milestone = mock("milestone", :title => "Milestone Title")
    Lighthouse::Milestone.stub!(:find).and_return(@milestone)
  end
  
  it "should find the milestone" do
    Lighthouse::Milestone.should_receive(:find).with("Milestone ID", :params => {:project_id => "project_id"}).and_return(@milestone)
    
    @fresnel_ticket.milestone_title
  end
  
  it "should return the title of the found milestone" do
    @fresnel_ticket.milestone_title.should == "Milestone Title"
  end
  
  it "should not crash if the milestone is not found" do
    Lighthouse::Milestone.should_receive(:find).and_raise(ActiveResource::Redirection.new(mock('resource moved', :code => "moved")))
    
    @fresnel_ticket.milestone_title.should be_nil
  end
  
end