require "credential"
module TitleBar
  
  def button_pressed(event)
    show_spinner(scene.stage.name) { title_bar }
  end
  
  def title_bar
    if id == "logout"
      production.stage_manager.notify_of_logout(stage_name)
      scene.load("login")
    else
      scene.load(id)
    end
  end
  
  private ####################
  
  def stage_name
    return scene.stage.name
  end
end