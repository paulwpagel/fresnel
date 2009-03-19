
module LoadAddProject
  
  def mouse_clicked(event)
    show_spinner(scene.stage.name) do
      load_add_project
    end
  end
  
  def load_add_project
    scene.load("add_project")
  end
end