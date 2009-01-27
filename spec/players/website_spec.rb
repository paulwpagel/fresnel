require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'website'

describe Website do
  before(:each) do
    mock_lighthouse
    producer.production.current_project = mock('Project', :open_tickets => [], :hyphenated_name => "some-project", :id => 12345)
    @lighthouse_client.stub!(:account).and_return("8thlight")
  end
  
  uses_scene :list_tickets
  
  it "should build the url" do    
    scene.find("website_link").url.should == "http://8thlight.lighthouseapp.com/projects/12345-some-project/overview"
  end
end