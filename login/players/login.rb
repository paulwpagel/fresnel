require File.expand_path(File.dirname(__FILE__) + "/../../lib/lighthouse_client")
require File.expand_path(File.dirname(__FILE__) + "/../../lib/credential")

module Login
  
  def button_pressed(e)
    attempt_login
  end
  
  def attempt_login
    account = scene.find('account')
    username = scene.find('username')
    password = scene.find('password')

    client = LighthouseClient.new
    
    logged_in = client.login_to(account.text, username.text, password.text)

    if logged_in
      scene.load('ticket') 
      scene.production.credential = Credential.new(:account => account.text, :login => username.text, :password => password.text, :logged_in => true)
    else
      scene.find("error_message").text = "Authentication Failed, please try again"
    end
    
  end
  
end