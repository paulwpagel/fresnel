require File.dirname(__FILE__) + '/spec_helper'
require "stage_manager"

describe StageManager, "each_name" do
  before(:each) do
    CredentialSaver.stub!(:load_account_names).and_return([])
  end
  
  it "get the credentials from the credential saver" do
    CredentialSaver.should_receive(:load_account_names).at_least(1).times.and_return([])
    
    StageManager.each_name do |name|
    end
  end
  
  it "should return a scene even if there are no accounts for one account" do
    CredentialSaver.stub!(:load_account_names).and_return([])
    
    accounts = []
    StageManager.each_name do |name|
      accounts << name
    end
    accounts.should == ["default"]
  end
  
  it "should yield for one account" do
    CredentialSaver.stub!(:load_account_names).and_return(["one"])
    
    accounts = []
    StageManager.each_name do |name|
      accounts << name
    end
    accounts.should == ["one"]
  end
  
  it "should yield for two accounts" do
    CredentialSaver.stub!(:load_account_names).and_return(["one", "two"])
    
    accounts = []
    StageManager.each_name do |name|
      accounts << name
    end
    accounts.should == ["one", "two"]
  end
end

describe StageManager, "attempt_login" do
  before(:each) do
    @credential = mock("credential", :account => "account 1", :login => "username 1", :password => "password 1")
    Credential.stub!(:new).and_return(@credential)
    CredentialSaver.stub!(:save)
    @stage_manager = StageManager.new
  end
  
  describe "returning true" do
    before(:each) do
      Lighthouse::LighthouseApi.stub!(:login_to).and_return(true)
      @second_credential = mock("credential 2", :account => "account 2", :login => "username 2", :password => "password 2")
    end
    
    it "should make a credential for the stage" do
      Credential.should_receive(:new).with("account 1", "username 1", "password 1", nil, true).and_return(@credential)
      
      attempt_login
      
      @stage_manager["stage name 1"].credential.should == @credential
    end

    it "should return the appropriate credential for the given stage" do
      Credential.stub!(:new).and_return(@credential, @second_credential)
      attempt_login(1)
      attempt_login(2)
      
      @stage_manager["stage name 1"].credential.should == @credential
      @stage_manager["stage name 2"].credential.should == @second_credential
    end
    
    it "should save the credentials" do
      Credential.stub!(:new).and_return(@credential, @second_credential)
      attempt_login(1)
      CredentialSaver.should_receive(:save).with([@credential, @second_credential])
      
      attempt_login(2)
    end
    
    it "should have a client" do
      attempt_login
      
      @stage_manager["stage name 1"].client.should == Lighthouse::LighthouseApi
    end
    
    it "should reset the credentials before returning the client" do
      attempt_login
      Lighthouse::LighthouseApi.should_receive(:login_to).with("account 1", "username 1", "password 1")
      
      @stage_manager["stage name 1"]
    end
    
    it "should attempt to log in" do
      Lighthouse::LighthouseApi.should_receive(:login_to).with("account 1", "username 1", "password 1")
      
      attempt_login
    end
    
    it "should indicate a successful login" do
      attempt_login.should be_true
    end
  end
  
  describe "returning false" do
    before(:each) do
      Lighthouse::LighthouseApi.stub!(:login_to).and_return(false)
    end
    
    it "should indicate a failed login" do
      attempt_login.should be_false
    end
    
    it "should not save the credentials" do
      CredentialSaver.should_not_receive(:save)
      
      attempt_login
    end
  end
  def attempt_login(number=1)
    @stage_manager.attempt_login("account #{number}", "username #{number}", "password #{number}", true, "stage name #{number}")
  end
end