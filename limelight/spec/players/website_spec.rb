require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'website'
class Browser
end
describe Website do
  before(:each) do
    mock_stage_manager
    @lighthouse_client.stub!(:account).and_return("8thlight")
    @website, @scene, @production = create_player(Website, 
                                                :scene => {:stage => @stage}, 
                                                :production => {:stage_manager => @stage_manager})
    @project.stub!(:id).and_return(12345)
    @project.stub!(:hyphenated_name).and_return("some-project")
  end
  
    
  it "should use the stage name to get the appropriate stage info" do
    @stage_manager.should_receive(:[]).with("stage name").at_least(1).times.and_return(@stage_info)

    @website.url
  end
  
  it "should use the stage name to get the lighthouse_client" do
    @stage_manager.should_receive(:client_for_stage).with("stage name").and_return(@lighthouse_client)

    @website.url
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