require "credential"

module NoInternetRetry
  
  def button_pressed(event)
    no_internet
  end
  
  
  def no_internet
    Credential.load_saved
    scene.load("list_tickets")
  rescue SocketError
    
    
  end
end