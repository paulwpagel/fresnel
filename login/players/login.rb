require File.expand_path(File.dirname(__FILE__) + "/../../lib/lighthouse_client")

module Login
  
  def button_pressed(e)
    attempt_login
  end
  
  def attempt_login
    account = scene.find('account')
    username = scene.find('username')
    password = scene.find('password')

    client = LighthouseClient.new
    client.login_to(account.text, username.text, password.text)
  end
  
end