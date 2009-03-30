module SaveMilestone
  prop_reader :existing_milestones
  
  def button_pressed(event)
    show_spinner { save }
  end
  
  def save
    current_project.update_milestone(milestone_id, {:title => new_title, :goals => new_goals, :due_on => new_due_on})
    existing_milestones.remove_all
    existing_milestones.build(:milestones => current_project.milestones) do
      __install "list_tickets/existing_milestone_list.rb", :milestones => @milestones
    end
  end
  
  private ###########
  
  def new_title
    title_prop = scene.find("milestone_title_#{milestone_id}")
    return title_prop.text if title_prop
  end
  
  def new_goals
    goal_prop = scene.find("milestone_goals_#{milestone_id}")
    return goal_prop.text if goal_prop
  end
  
  def new_due_on
    date_prop = scene.find("milestone_due_on_#{milestone_id}")
    return date_prop.text if date_prop
  end
  
  def milestone_id
    return id.split('_')[-1].to_i
  end
  
  def current_project
    return production.stage_manager[scene.stage.name].current_project
  end
end