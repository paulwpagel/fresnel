require "credential"

module Login
  
  prop_reader :username
  prop_reader :account
  prop_reader :password
  prop_reader :error_message
  
  def button_pressed(e)
    show_spinner { login}
  end

  def login
    account_text = account.text
    username_text = username.text
    password_text = password.text
    
    if production.lighthouse_client.login_to(account_text, username_text, password_text)
      set_credentials(account_text, username_text, password_text)
      scene.load('list_tickets')
    else
      set_error "Authentication Failed, please try again"
    end
    
  rescue SocketError
    set_error "You must be connected to the internet to use Fresnel."
  end
  
private
  def set_error(message)
    error_message.text = message
    password.text = ''
  end

  def set_credentials(account, username, password)
    if scene.find("save_credentials").checked?
      Credential.set(:account => account, :login => username, :password => password, :save_credentials => true)
      Credential.save
    else
      Credential.set
    end
  end
  
end