module CreateMilestone
  prop_reader :new_milestone_title, :new_milestone_goals, :new_milestone_due_on, :milestone_lister
  
  def button_pressed(event)
    show_spinner { create }
  end
  
  def create
    current_project.create_milestone(:title => new_milestone_title.text, :goals => new_milestone_goals.text, :due_on => new_milestone_due_on.text)
  end
  
  private ##################
  
  def current_project
    return production.stage_manager[scene.stage.name].current_project
  end
end