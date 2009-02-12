require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'scene_chooser'

describe SceneChooser do
  
  before(:each) do
    Credential.stub!(:load_saved)
    @scene_chooser = SceneChooser.new
  end
  
  it "should load login" do
    Credential.should_receive(:account).and_return(false)

    @scene_chooser.first_scene.should == "login"
  end
  
  it "should load list_tickets if the credentials are saved" do
    Credential.should_receive(:account).and_return true
    
    @scene_chooser.first_scene.should == "list_tickets"
  end
  
  it "should load saved credentials" do
    Credential.should_receive(:load_saved)

    @scene_chooser.first_scene
  end
  
  it "should load no_internet if the credentials are saved but there is no internet" do
    Credential.should_receive(:load_saved).and_raise(SocketError)
    
    @scene_chooser.first_scene.should == "no_internet"
  end
  
end
