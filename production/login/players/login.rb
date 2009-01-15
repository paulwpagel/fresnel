require "credential"

module Login
  
  def button_pressed(e)
    load_inputs
    log_in
  end
  
  def log_in
    # TODO - EWM - Should this exception handling be part of base.login_to ?
    begin
      logged_in = production.lighthouse_client.login_to(@account.text, @username.text, @password.text)
      attempt_login(logged_in)
    rescue URI::InvalidURIError
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
  
  def attempt_login(logged_in)
    if logged_in
      scene.load('project') 
      scene.production.credential = Credential.new(:account => @account.text, :login => @username.text, :password => @password.text, :logged_in => true)
      scene.production.credential.save if scene.find("save_credentials").checked?
    else
      error_with "Authentication Failed, please try again"
    end
  end
end