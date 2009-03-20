require File.dirname(__FILE__) + '/spec_helper'
require "stage_manager"

describe StageManager, "initialization" do
  before(:each) do
    @credential = mock("credential", :account => "some account", :null_object => true)
    CredentialSaver.stub!(:load_saved).and_return([@credential])
    @client = mock("client", :null_object => true)
    @stage_info = mock("stage_info", :credential => @credential, :client => @client)
    StageInfo.stub!(:new).and_return(@stage_info)
  end
  
  it "should load the stored credentials" do
    CredentialSaver.should_receive(:load_saved).and_return([])
    StageManager.new
  end
  
  it "should create a stage info item for a loaded credential" do
    StageInfo.should_receive(:new).with(:credential => @credential).and_return(@stage_info)

    StageManager.new
  end
  
  it "should put the stage info item in the stage info list" do
    stage_manager = StageManager.new
    
    stage_manager["some account"].should == @stage_info
  end
end

describe StageManager, "each_stage" do
  before(:each) do
    CredentialSaver.stub!(:load_account_names).and_return([])
  end
  
  it "get the credentials from the credential saver" do
    CredentialSaver.should_receive(:load_account_names).at_least(1).times.and_return([])
    
    StageManager.each_stage do |stage_name, scene_name|
    end
  end
  
  it "should return a scene even if there are no accounts for one account" do
    CredentialSaver.stub!(:load_account_names).and_return([])
    
    stage_names = []
    scene_names = []
    StageManager.each_stage do |stage_name, scene_name|
      stage_names << stage_name
      scene_names << scene_name
    end
    stage_names.should == ["default"]
    scene_names.should == ["login"]
  end
  
  it "should yield for one account" do
    CredentialSaver.stub!(:load_account_names).and_return(["one"])
    
    stage_names = []
    scene_names = []
    StageManager.each_stage do |stage_name, scene_name|
      stage_names << stage_name
      scene_names << scene_name
    end
    stage_names.should == ["one"]
    scene_names.should == ["list_tickets"]
  end
  
  it "should yield for two accounts" do
    CredentialSaver.stub!(:load_account_names).and_return(["one", "two"])
    
    stage_names = []
    scene_names = []
    StageManager.each_stage do |stage_name, scene_name|
      stage_names << stage_name
      scene_names << scene_name
    end
    stage_names.should == ["one", "two"]
    scene_names.should == ["list_tickets", "list_tickets"]
  end
end

def attempt_login(number=1)
  @stage_manager.attempt_login("account #{number}", "username #{number}", "password #{number}", true, "stage name #{number}")
end

describe StageManager, "attempt_login" do
  before(:each) do
    CredentialSaver.stub!(:load_saved).and_return([])
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
  
end

describe StageManager, "notify_of_project_change" do
  before(:each) do
    CredentialSaver.stub!(:load_saved).and_return([])
    @project = mock("project")
    @credential = mock("credential", :account => "account 1", :login => "username 1", :password => "password 1", :remember_me? => nil, :project_name= => nil)
    Credential.stub!(:new).and_return(@credential)
    
    Lighthouse::LighthouseApi.stub!(:login_to).and_return(true)
    Lighthouse::LighthouseApi.stub!(:find_project).and_return(@project)
    @stage_manager = StageManager.new
  end
  
  it "should set the credential's project to the given project name" do
    attempt_login
    
    @credential.should_receive(:project_name=).with("project_name")
    @stage_manager.notify_of_project_change("project_name", "stage name 1")
  end
  
  it "should save the credentials" do
    attempt_login
    
    CredentialSaver.should_receive(:save).with([@credential])
    
    @stage_manager.notify_of_project_change("project_name", "stage name 1")
  end
  
  describe "updating the current project" do
    it "should get it from the client" do
      attempt_login
      
      Lighthouse::LighthouseApi.should_receive(:find_project).with("project_name").and_return(@project)
      @stage_manager.notify_of_project_change("project_name", "stage name 1")
      @stage_manager["stage name 1"].current_project.should == @project
    end
  end
  
end