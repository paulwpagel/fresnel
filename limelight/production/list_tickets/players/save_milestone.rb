module SaveMilestone
  def button_pressed(event)
    show_spinner { save }
  end
  
  def save
    current_project.update_milestone(milestone_id, :title => new_title)
  end
  
  private ###########
  
  def new_title
    title_prop = scene.find("milestone_title_#{milestone_id}")
    return title_prop.text if title_prop
  end
  
  def milestone_id
    return id.split('_')[-1].to_i
  end
  
  def current_project
    return production.stage_manager[scene.stage.name].current_project
  end
end