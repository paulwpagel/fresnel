require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")
require "lighthouse/lighthouse_api/first_project_chooser"

describe Lighthouse::LighthouseApi::FirstProjectChooser do
  before(:each) do
    Credential.stub!(:project_name).and_return("Project One")
    @chooser = Lighthouse::LighthouseApi::FirstProjectChooser.new
    @project = mock('project')
    Lighthouse::LighthouseApi.stub!(:projects).and_return([@project])
  end
  
  it "should use the credential to get the project" do
    Credential.stub!(:save_credentials?).and_return(true)
    Lighthouse::LighthouseApi.should_receive(:find_project).with("Project One").and_return(@project)
    
    @chooser.get_project.should == @project
  end
  
  it "should use the first project if the credentials are not saved" do
    Credential.stub!(:save_credentials?).and_return(false)
    Lighthouse::LighthouseApi.should_receive(:projects).and_return([@project])
    
    @chooser.get_project.should == @project
  end
  
  it "should return the first project if the user has saved credentials but the project does is invalid" do
    Credential.stub!(:save_credentials?).and_return(true)
    Lighthouse::LighthouseApi.stub!(:find_project).and_return(nil)
    
    @chooser.get_project.should == @project
  end
end