require "credential"
module TitleBar
  
  def button_pressed(event)
    show_spinner { title_bar }
  end
  
  def title_bar
    if id == "logout"
      Credential.clear_saved
      scene.load("login")
    else
      scene.load(id)
    end
    
  end
  
end