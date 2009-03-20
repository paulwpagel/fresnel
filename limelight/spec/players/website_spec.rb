require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'website'
class Browser
end
describe Website do
  before(:each) do
    mock_stage_manager
    @project.stub!(:id).and_return(12345)
    @project.stub!(:hyphenated_name).and_return("some-project")
    @lighthouse_client.stub!(:account).and_return("8thlight")
    @website, @scene, @production = create_player(Website, 
                                                :scene => {}, 
                                                :production => {:current_project => @project, :stage_manager => @stage_manager})
  end
  
  it "should show url" do
    @browser = mock('browser')
    @browser.should_receive(:showInBrowser).with(@website.url)
    Browser.should_receive(:new).and_return(@browser)
    
    @website.show_url
  end
  
  it "should build the url" do    
    @website.url.should == "http://8thlight.lighthouseapp.com/projects/12345-some-project/overview"
  end
end