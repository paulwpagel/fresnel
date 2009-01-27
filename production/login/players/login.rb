require "credential"

module Login
  
  def button_pressed(e)    
    load_inputs
    log_in
  end
  
  def log_in
    if attempt_login
      handle_successful_login
    else
      error_with "Authentication Failed, please try again"
    end
  end
  
  def error_with(message)
    scene.find("error_message").text = message
    @password.text = ""
  end
  
  def load_inputs
    @account = scene.find('account')
    @username = scene.find('username')
    @password = scene.find('password')
  end
  
  def attempt_login
    return production.lighthouse_client.login_to(@account.text, @username.text, @password.text)
  end
  
  private #####################
  
  def handle_successful_login
    if scene.find("save_credentials").checked?
      credential = Credential.new(:account => @account.text, :login => @username.text, :password => @password.text)
      credential.save
    end
    scene.load('list_tickets')
  end
end