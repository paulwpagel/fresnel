require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "credential"

describe Credential do
  before(:each) do
    Encrypter.stub!(:encrypt).and_return("encrypted data")
    @file = mock(File, :write => nil)
    File.stub!(:open).and_yield(@file)
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
  
  it "should encrypt the password on save" do
    Encrypter.should_receive(:encrypt).with("guessingwontwork")
    
    @credential.save
  end
  
  it "should encrypt the username on save" do
    Encrypter.should_receive(:encrypt).with("paul")
    
    @credential.save
  end
  
  it "should encrypt the account on save" do
    Encrypter.should_receive(:encrypt).with("AFlight")
    
    @credential.save
  end
  
  it "should make a file to save the encrypted data" do
    File.should_receive(:open).with(anything(), "w+")
    
    @credential.save
  end
  
  it "should write the encrypted data" do
    @file.should_receive(:write).with("encrypted data\n").exactly(3).times
    
    @credential.save
  end
end