module CancelEditMilestone
  prop_reader :existing_milestones
  
  def button_pressed(event)
    cancel
  end
  
  def mouse_clicked(event)
  end
  
  def cancel
    existing_milestones.refresh
  end
end