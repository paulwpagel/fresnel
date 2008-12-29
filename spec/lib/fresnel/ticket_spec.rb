require File.dirname(__FILE__) + '/../../spec_helper'
require "fresnel/ticket"

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

describe Lighthouse::Ticket, "comments" do
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
# 
# describe Lighthouse::Ticket, "fresnel versions" do
#   before(:each) do
#     @ticket = Lighthouse::Ticket.new
#     @version_one = mock("version")
#     @versions = [@version_one]
#     @ticket.stub!(:versions).and_return(@versions)
#     @fresnel_version = mock(TicketVersion)
#     TicketVersion.stub!(:new).and_return(@fresnel_version)
#   end
#   
#   it "should have a fresnel version for one lighthouse version" do
#     TicketVersion.should_receive(:new).with(@version_one).and_return(@fresnel_version)
#     
#     @ticket.fresnel_versions.should == [@fresnel_version]
#   end
#   
#   it "should have a fresnel version for a second lighthouse version" do
#     version_two = mock("version")
#     @versions << version_two
#     TicketVersion.should_receive(:new).with(version_two).and_return(@fresnel_version)
#     
#     @ticket.fresnel_versions.should == [@fresnel_version, @fresnel_version]
#   end
# end
# 
