require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'title_bar'

describe "title_bar" do

  before(:each) do
    mock_lighthouse
    producer.production.current_project = @project
  end
  
  uses_scene :list_tickets
  
  before(:each) do
    @event = nil
    scene.stub!(:load)
    Credential.stub!(:clear_saved)
  end
  
  it "should redirect to the add ticket scene" do
    scene.should_receive(:load).with("add_ticket")

    press("add_ticket")
  end

  it "should go to the project scene when the list projects button is clicked" do
    scene.should_receive(:load).with("project")

    press("project")
  end
  
  it "should go to the list ticket scene when the list tickets button is clicked" do
    scene.should_receive(:load).with("list_tickets")

    press("list_tickets")
  end
  
  it "should log the user out when the logout button is clicked" do
    Credential.should_receive(:clear_saved)

    press("logout")
  end

  it "should not clear the credentials if a different button is pressed" do
    Credential.should_not_receive(:clear_saved)
    
    press("list_tickets")
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
