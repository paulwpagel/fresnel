module TitleBar
  
  def button_pressed(event)
    show_spinner do
      if id == "logout"
        Credential.clear_saved
        scene.load("login")
      else
        scene.load(id)
      end
    end
  end
  
end