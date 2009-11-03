module CloseConfigureMilestones
  prop_reader :configure_milestones_wrapper
  
  def mouse_clicked(event)
    close
  end
  
  def close
    scene.remove(configure_milestones_wrapper)
  end
end