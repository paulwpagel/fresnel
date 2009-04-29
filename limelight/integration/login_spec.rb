require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/helpers/login_helper")
require "credential_saver"

describe "Login Integration Test" do
  include LoginHelper
  
  before(:each) do
    CredentialSaver.filename = File.expand_path("~/.integration_test_credentials")
    CredentialSaver.clear_all
  end

  it "should be able to login" do
    scene = producer.open_scene("login", producer.theater.stages[0])
    
    login_with_credentials(scene)
    
    scene.stage.current_scene.name.should == "list_tickets"
  end
  
  it "should open a second stage to the login screen when adding another account" do
    scene = producer.open_scene("login", producer.theater.stages[0])
  
    login_with_credentials(scene)
    
    scene.stage.current_scene.find("extra_account").mouse_clicked(nil)
    producer.theater.stages.size.should == 2
    
    scene = producer.open_scene("login", producer.theater.stages[1])
    scene.name.should == "login"
  end
  
  it "should only show projects for the second account on the second account" do
    scene = producer.open_scene("login", producer.theater.stages[0])

    login_with_credentials(scene)
    scene.stage.current_scene.find("extra_account").mouse_clicked(nil)
    
    scene = producer.open_scene("login", producer.theater.stages[1])
    login_with_credentials(scene, :account => "Account Two")
    scene = scene.stage.current_scene
    scene.find("project_selector").choices.should == ["Project Three"]
  end
end
