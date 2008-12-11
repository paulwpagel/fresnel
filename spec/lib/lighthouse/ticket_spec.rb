require File.dirname(__FILE__) + '/../../spec_helper'
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