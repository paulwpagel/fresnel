require File.dirname(__FILE__) + '/../../spec_helper'
require "fresnel/ticket"

describe Fresnel::Ticket, "initialize" do
  before(:each) do
    @lighthouse_ticket = mock("Lighthouse::Ticket", :assigned_user_id => 123, :id => "ticket_id")
  end
  
  it "should have no versions if the given ticket has none" do
    @lighthouse_ticket.should_receive(:versions).and_raise(NoMethodError)
    
    @fresnel_ticket = Fresnel::Ticket.new(@lighthouse_ticket)
    
    @fresnel_ticket.versions.should == []
  end
end

describe Fresnel::Ticket, "assigned_user" do
  before(:each) do
    @lighthouse_ticket = mock("Lighthouse::Ticket", :assigned_user_id => 123, :versions => [])
    @fresnel_ticket = Fresnel::Ticket.new(@lighthouse_ticket)
    @muser = mock(Lighthouse::User, :name => "Denny")
    Lighthouse::User.stub!(:find).and_return(@muser)
  end

  it "should have an assigned_user" do
    Lighthouse::User.should_receive(:find).with(123)
    
    @fresnel_ticket.assigned_user
  end
  
  it "should find the assigned_user" do    
    @fresnel_ticket.assigned_user.should == @muser
  end
  
  it "should return the assigned_user_name" do
    @fresnel_ticket.assigned_user_name.should == "Denny"
  end
  
  it "should be blank if the user isn't found" do
    Lighthouse::User.stub!(:find).and_return(nil)
    
    @fresnel_ticket.assigned_user_name.should == ''
  end
end

describe Fresnel::Ticket, "with no assigned_user" do
  before(:each) do
    @lighthouse_ticket = mock("Lighthouse::Ticket", :assigned_user_id => 123, :versions => [])
    @fresnel_ticket = Fresnel::Ticket.new(@lighthouse_ticket)
    response = mock('unauthorized', :code => "500 Internal Server Error")
    Lighthouse::User.stub!(:find).and_raise(ActiveResource::ServerError.new(response))
  end
  
  it "should return nothing if it cannot find the user" do    
    @fresnel_ticket.assigned_user.should == nil
  end
end

describe Fresnel::Ticket, "description" do
  before(:each) do
    @version_one = mock("version", :body => "Some Description")
    @lighthouse_ticket = mock("Lighthouse::Ticket", :versions => [@version_one], :assigned_user_id => nil)
    @fresnel_ticket = Fresnel::Ticket.new(@lighthouse_ticket)
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
    @fresnel_ticket = Fresnel::Ticket.new(@lighthouse_ticket)
    
    @fresnel_ticket.description.should == ""
  end
end

describe Fresnel::Ticket, "comments" do
  before(:each) do
    @version_one = mock("version", :body => "Some Description")
    @versions = [@version_one]
    @lighthouse_ticket = mock("Lighthouse::Ticket", :versions => @versions, :assigned_user_id => nil)
    @fresnel_ticket = Fresnel::Ticket.new(@lighthouse_ticket)
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

describe Fresnel::Ticket, "fresnel versions" do
  before(:each) do
    @original_state = mock("original version")
    @version_one = mock("version")
    @versions = [@original_state, @version_one]
    @lighthouse_ticket = mock("Lighthouse::Ticket", :versions => @versions, :assigned_user_id => nil)
    @fresnel_ticket = Fresnel::Ticket.new(@lighthouse_ticket)

    @fresnel_version = mock(Fresnel::TicketVersion)
    Fresnel::TicketVersion.stub!(:new).and_return(@fresnel_version)
  end
  
  it "should have a fresnel version for one lighthouse version" do
    Fresnel::TicketVersion.should_receive(:new).with(@version_one).and_return(@fresnel_version)
    
    @fresnel_ticket.versions.should == [@fresnel_version]
  end
  
  it "should have a fresnel version for a second lighthouse version" do
    version_two = mock("version")
    @versions << version_two
    Fresnel::TicketVersion.should_receive(:new).with(version_two).and_return(@fresnel_version)
    
    @fresnel_ticket.versions.should == [@fresnel_version, @fresnel_version]
  end
end

describe Fresnel::Ticket, "find" do
  before(:each) do
    @ticket_one = mock("Lighthouse::Ticket")
    @tickets = [@ticket_one]
    @fresnel_ticket = mock(Fresnel::Ticket)
    Fresnel::Ticket.stub!(:new).and_return(@fresnel_ticket)
    Lighthouse::Ticket.stub!(:find).and_return(@tickets)
  end
  
  it "should call Lighthouse ticket find with one parameter" do
    Lighthouse::Ticket.should_receive(:find).with("some param").and_return([])
    
    Fresnel::Ticket.find("some param")
  end
  
  it "should call Lighthouse ticket find with one parameter" do
    Lighthouse::Ticket.should_receive(:find).with("first param", "second param").and_return([])
    
    Fresnel::Ticket.find("first param", "second param")
  end
  
  it "should make fresnel tickets for the first ticket found" do
    Fresnel::Ticket.should_receive(:new).with(@ticket_one)
    
    Fresnel::Ticket.find("some param")
  end 

  it "should make fresnel tickets for the second ticket found" do
    @ticket_two = mock("Lighthouse::Ticket")
    @tickets << @ticket_two
    Fresnel::Ticket.should_receive(:new).with(@ticket_two)

    Fresnel::Ticket.find("some param")
  end
  
  it "should return the fresnel tickets" do
    @ticket_two = mock("Lighthouse::Ticket")
    @tickets << @ticket_two
    
    Fresnel::Ticket.find("some param").should == [@fresnel_ticket, @fresnel_ticket]
  end
end

describe Fresnel::Ticket, "lighthouse ticket attributes" do
  before(:each) do
    @lighthouse_ticket = mock("Lighthouse::Ticket", :versions => [], :assigned_user_id => nil,
                                    :id => "ticket_id", :state => "Open", :title => "Some Title", :milestone_id => "Milestone ID")
    @fresnel_ticket = Fresnel::Ticket.new(@lighthouse_ticket)
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
end

describe Fresnel::Ticket, "editing" do
  before(:each) do
    @lighthouse_ticket = mock("Lighthouse::Ticket", :versions => @versions, :assigned_user_id => nil)
    @fresnel_ticket = Fresnel::Ticket.new(@lighthouse_ticket)
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

describe Fresnel::Ticket, "changed attributes" do
  before(:each) do
    lighthouse_version = mock("lighthouse_version")
    @versions = [lighthouse_version, lighthouse_version, lighthouse_version, lighthouse_version]
    @fresnel_version = mock('fresnel_version')
    Fresnel::TicketVersion.stub!(:new).and_return(@fresnel_version)
    @lighthouse_ticket = mock("Lighthouse::Ticket", :versions => @versions, :assigned_user_id => nil)
    @fresnel_ticket = Fresnel::Ticket.new(@lighthouse_ticket)    
    @changed_attributes_list = mock('changed_attributes_list')
    @changed_attributes = mock("changed_attributes", :list => @changed_attributes_list)
    Fresnel::ChangedAttributes.stub!(:new).and_return(@changed_attributes)
  end
  
  it "should create a changed attributes with the versions from the given one" do
    Fresnel::ChangedAttributes.should_receive(:new).with([@fresnel_version, @fresnel_version], @fresnel_ticket).and_return(@changed_attributes)
    
    @fresnel_ticket.changed_attributes_for_version(1)
  end
  
  it "should return the list ofchanged_attributes" do    
    @fresnel_ticket.changed_attributes_for_version(1).should == @changed_attributes_list
  end
end