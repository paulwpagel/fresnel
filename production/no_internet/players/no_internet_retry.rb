require "credential"

module NoInternetRetry
  
  def button_pressed(event)
    Credential.load_saved
    scene.load("list_tickets")
  rescue SocketError
    
  end
end