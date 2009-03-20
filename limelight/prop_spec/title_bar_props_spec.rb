require File.dirname(__FILE__) + '/spec_helper'
require 'limelight/specs/spec_helper'

describe "title bar props" do
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
  
  it "should have a link to the website" do
    website_link = scene.find("website_link")
    website_link.players.should == "website"
  end
  
  it "should have a button to login into a second account" do
    extra_account = scene.find("extra_account")
    extra_account.players.should == "extra_account"
  end
end