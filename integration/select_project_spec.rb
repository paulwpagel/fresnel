require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'limelight/specs/spec_helper'

describe "Select Project Integration" do
  
  it "should be able to login" do
    scene = login_scene(producer)
     
    scene.find("account").text = "fresnel"
    scene.find("username").text = "Tommy James"
    scene.find("password").text = "abracadabrah"

    press_button("login_button", scene)
    
    scene = producer.production.theater['default'].current_scene
    scene.name.should == "project"
  end
    
end
