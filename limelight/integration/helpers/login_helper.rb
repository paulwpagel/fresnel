require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

module LoginHelper
  
  def login_with_credentials(scene, options = {})
    options[:account] ||= "Account One"
    options[:username] ||= "Tommy James"
    options[:password] ||= "abracadabrah"
    options[:remember_me?] ||= true
    
    scene.find("account").text = options[:account]
    scene.find("username").text = options[:username]
    scene.find("password").text = options[:password]
    scene.find("save_credentials").text = options[:remember_me?]
    
    press_button("login_button", scene)
  end
end