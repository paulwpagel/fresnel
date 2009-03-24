require "credential"

module Login
  
  prop_reader :account
  prop_reader :username
  prop_reader :password
  prop_reader :save_credentials
  prop_reader :error_message
  
  def button_pressed(e)
    show_spinner { login}
  end

  def login
    account_text = account.text
    username_text = username.text
    password_text = password.text
    remember_me = save_credentials.checked?
    
    if production.stage_manager.attempt_login(account_text, username_text, password_text, remember_me, stage_name)
      scene.stage.title = "Fresnel - #{account_text}"
      scene.load('list_tickets')
    else
      set_error "Authentication Failed, please try again"
    end
    
    rescue SocketError
      set_error "You must be connected to the internet to use Fresnel."
  end
  
  private ##################################

  def set_error(message)
    error_message.text = message
    password.text = ''
  end
  
  def stage_name
    scene.stage.name
  end
  
end