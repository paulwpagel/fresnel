require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'website'

describe Website do
  before(:each) do
    mock_lighthouse
    producer.production.current_project = mock('Project', :open_tickets => [])
    @client = mock("Lighthouse", :account => "8thlight")
    producer.production.lighthouse_client = @client
  end
  
  uses_scene :list_tickets
  
  it "should include the account in the url" do
    @client.should_receive(:account).and_return("8thlight")
    
    scene.find("website_link").url.should match(/http:\/\/8thlight.lighthouseapp.com/)
  end
end

# http://8thlight.lighthouseapp.com/projects/22835-test-project/overview