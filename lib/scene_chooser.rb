require "credential"

class SceneChooser

  def first_scene
    Credential.load_saved
    if Credential.account
      @first_scene = "list_tickets"
    else  
      @first_scene = "login"
    end
    
  rescue SocketError
    @first_scene = "no_internet"
  end
  
end