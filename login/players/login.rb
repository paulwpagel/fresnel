module Login
  
  def button_pressed(e)
    attempt_login
  end
  
  def attempt_login
    account = scene.find('account')
    username = scene.find('username')
    password = scene.find('password')

    client = LighthouseClient.new
    client.attempt_login(account.text, username.text, password.text)
    
  end
  
end