module DeleteMilestone
  prop_reader :existing_milestones
  
  def mouse_clicked(event)
    show_spinner { delete }
  end
  
  def delete
    current_project.delete_milestone(milestone_id)
    existing_milestones.refresh
  end
  
  private #####################
  
  def milestone_id
    return id.split('_')[2].to_i
  end
  
  def current_project
    return production.stage_manager[scene.stage.name].current_project
  end
end