require File.dirname(__FILE__) + '/../../../spec_helper'
require "lighthouse/ticket"

describe Lighthouse::Ticket do
  
  before(:each) do
    @ticket = Lighthouse::Ticket.new
    @ticket.stub!(:assigned_user_id).and_return(123)
    @muser = mock(Lighthouse::User, :name => "Denny")
    Lighthouse::User.stub!(:find).and_return(@muser)
  end
  
  it "should have an assigned_user" do
    Lighthouse::User.should_receive(:find).with(123)
    
    @ticket.assigned_user
  end
  
  it "should find the assigned_user" do    
    @ticket.assigned_user.should == @muser
  end
  
  it "should return assigned_user_name" do
    @ticket.assigned_user_name.should == "Denny"
  end
  
  it "should be blank if the user isn't found" do
    Lighthouse::User.stub!(:find).and_return(nil)
    
    @ticket.assigned_user_name.should == ''
  end
  
end

describe Lighthouse::Ticket, "with no assigned_user" do
  before(:each) do
    @ticket = Lighthouse::Ticket.new
    @ticket.stub!(:assigned_user_id).and_return(123)
    response = mock('unauthorized', :code => "500 Internal Server Error")
    Lighthouse::User.stub!(:find).and_raise(ActiveResource::ServerError.new(response))
  end
  
  it "should return nothing if it cannot find the user" do    
    @ticket.assigned_user.should == nil
  end
end

describe Lighthouse::Ticket, "description" do
  before(:each) do
    @ticket = Lighthouse::Ticket.new
    @version_one = mock("version", :body => "Some Description")
    @ticket.stub!(:versions).and_return([@version_one])
  end

  it "should have get the description from the first version" do
    @version_one.should_receive(:body)
    
    @ticket.description
  end
  
  it "should return the description" do
    @ticket.description.should == "Some Description"
  end
  
  it "should not crash if there are no versions" do
    @ticket.stub!(:versions).and_return([])
    
    @ticket.description.should == ""
  end
end

describe Lighthouse::Ticket, "comments" do
  before(:each) do
    @ticket = Lighthouse::Ticket.new
    @version_one = mock("version", :body => "Some Description")
    @versions = [@version_one]
    @ticket.stub!(:versions).and_return(@versions)
  end
  
  it "should return an array of comments ingoring the description" do
    @ticket.comments.should == []
  end
  
  it "should give one comment" do
    version_two = mock("version", :body => "First Comment")
    @versions << version_two
    
    @ticket.comments.should == ["First Comment"]
  end

  it "should give two comments" do
    version_two = mock("version", :body => "First Comment")
    version_three = mock("version", :body => "Second Comment")
    @versions << version_two
    @versions << version_three
    
    @ticket.comments.should == ["First Comment", "Second Comment"]
  end
end

describe Lighthouse::Ticket, "fresnel versions" do
  before(:each) do
    @ticket = Lighthouse::Ticket.new
    @version_one = mock("version")
    @versions = [@version_one]
    @ticket.stub!(:versions).and_return(@versions)
    @fresnel_version = mock(TicketVersion)
    TicketVersion.stub!(:new).and_return(@fresnel_version)
  end
  
  it "should have a fresnel version for one lighthouse version" do
    TicketVersion.should_receive(:new).with(@version_one).and_return(@fresnel_version)
    
    @ticket.fresnel_versions.should == [@fresnel_version]
  end
  
  it "should have a fresnel version for a second lighthouse version" do
    version_two = mock("version")
    @versions << version_two
    TicketVersion.should_receive(:new).with(version_two).and_return(@fresnel_version)
    
    @ticket.fresnel_versions.should == [@fresnel_version, @fresnel_version]
  end
end