require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/helpers/login_helper")
require "credential_saver"

describe "Login Integration Test" do
  include LoginHelper
  
  it "should be able to login" do
    CredentialSaver.filename = File.expand_path("~/.integration_test_credentials")
    CredentialSaver.clear_all
    scene = producer.open_scene("login", producer.theater["default"])
    
    login_with_credentials(scene)
    
    scene = producer.production.theater['default'].current_scene
    scene.name.should == "list_tickets"
  end
    
end
