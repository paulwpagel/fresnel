require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'website'

describe Website do
  before(:each) do
    mock_lighthouse
    @project.stub!(:hyphenated_name).and_return("some-project")
    @project.stub!(:id).and_return(12345)
    @lighthouse_client.stub!(:account).and_return("8thlight")
    producer.production.current_project = @project
  end
  
  uses_scene :list_tickets
  
  it "should build the url" do    
    scene.find("website_link").url.should == "http://8thlight.lighthouseapp.com/projects/12345-some-project/overview"
  end
end