require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "credential"

describe Credential do
  before(:each) do
    @credential = Credential.new(:account => "AFlight", :login => "paul", :password => "guessingwontwork", :logged_in => true)
  end
  
  it "should have account, login, and password" do
    @credential.account.should == "AFlight"
    @credential.login.should == "paul"
    @credential.password.should == "guessingwontwork"
    @credential.logged_in?.should be(true)
  end
  
  it "should respond to save" do
    lambda{@credential.save}.should_not raise_error
  end
end