require "credential"
module TitleBar
  
  def mouse_clicked(event)
    show_spinner { title_bar }
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