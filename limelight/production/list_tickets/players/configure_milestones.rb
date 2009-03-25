module ConfigureMilestones
  def mouse_clicked(event)
    show_spinner { open_milestones }
  end
  
  def open_milestones
    scene.load("milestones")
  end
end