require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'website'

describe Website do
  before(:each) do
    mock_lighthouse
    @project.stub!(:id).and_return("12345")
    @project.stub!(:hyphenated_name).and_return("some-project")
    producer.production.current_project = @project
    @client = mock("Lighthouse", :account => "8thlight")
    producer.production.lighthouse_client = @client
  end
  
  uses_scene :list_tickets
  
  it "should build the url" do    
    scene.find("website_link").url.should == "http://8thlight.lighthouseapp.com/projects/12345-some-project/overview"
  end
end