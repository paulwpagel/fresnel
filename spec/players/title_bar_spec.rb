require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'title_bar'

describe "title_bar" do

  before(:each) do
    mock_lighthouse
    producer.production.current_project = mock('Project', :open_tickets => [])
  end
  
  uses_scene :list_tickets
  
  before(:each) do
    @event = nil
    scene.stub!(:load)
    Credential.stub!(:clear_saved)
  end
      
  it "should log the user out when the logout button is clicked" do
    Credential.should_receive(:clear_saved)

    press("logout")
  end

  it "should go back to the login page on logout" do
    scene.should_receive(:load).with("login")
    
    press("logout")
  end
  
  it "should have a link to the website" do
    website_link = scene.find("website_link")
    website_link.players.should == "website"
  end
  
  def press(id)
    scene.find(id).button_pressed(@event)
  end
end
