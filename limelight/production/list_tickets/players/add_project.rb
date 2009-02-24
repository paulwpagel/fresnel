module AddProject
  
  def mouse_clicked(event)
    show_spinner do
      scene.load("add_project")
    end
  end
end