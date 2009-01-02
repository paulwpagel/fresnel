require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'limelight/specs/spec_helper'

describe "Login Integration Test" do
  
  it "should be able to login" do
    scene = producer.open_scene("login", producer.theater["default"])
     
    scene.find("account").text = "fresnel"
    scene.find("username").text = "Tommy James"
    scene.find("password").text = "abracadabrah"

    press_button("login_button", scene)
    
    scene = producer.production.theater['default'].current_scene
    scene.name.should == "list_tickets"
  end
  
  it "should fail to login" do
    
  end
end
