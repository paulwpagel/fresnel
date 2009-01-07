module TitleBar
  
  def button_pressed(event)
    if id == "add_ticket"
      scene.load('add_ticket')
    else
      scene.load("project")
    end
  end
  
end