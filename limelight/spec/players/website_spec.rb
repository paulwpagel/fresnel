require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'website'
class Browser
end
describe Website do
  before(:each) do
    @project = mock("project", :id => 12345, :hyphenated_name => "some-project")
    @lighthouse_client = mock("lighthouse_client", :account => "8thlight")
    @website, @scene, @production = create_player(Website, 
                                                :scene => {}, 
                                                :production => {:current_project => @project, :lighthouse_client => @lighthouse_client})
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