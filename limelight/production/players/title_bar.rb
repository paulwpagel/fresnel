module TitleBar
  
  def button_pressed(event)
    if id == "logout"
      Credential.clear_saved
      scene.load("login")
    else
      scene.load(id)
    end
  end
  
end