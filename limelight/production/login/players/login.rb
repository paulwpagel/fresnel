require "credential"

module Login
  
  def button_pressed(e)
    show_spinner { login}
  end

  def login
    account = scene.text_for("account")
    username = scene.text_for("username")
    password = scene.text_for("password")

    if production.lighthouse_client.login_to(account, username, password)
      set_credentials(account, username, password)
      scene.load('list_tickets')
    else
      set_error "Authentication Failed, please try again"
    end
    
  rescue SocketError
    set_error "You must be connected to the internet to use Fresnel."
  end
  
private
  def set_error(message)
    scene.set_text_for("error_message", message)
    scene.set_text_for("password", '')
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