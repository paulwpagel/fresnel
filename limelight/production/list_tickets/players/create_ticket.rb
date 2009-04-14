module CreateTicket
  
  prop_reader :add_ticket_group
  
  def button_pressed(event)
    show_spinner { create_ticket }
  end
  
  def create_ticket
    add_ticket_group.build(:milestone_choices => milestone_choices, :assigned_user_choices => assigned_user_choices) do
      __install "list_tickets/create_ticket_props.rb"
    end
  end
  
  private ########################
  
  def current_project
    return production.stage_manager[scene.stage.name].current_project
  end
  
  def assigned_user_choices
    return ["None"] + current_project.user_names
  end
  
  def milestone_choices
    return ["None"] + current_project.milestone_titles
  end
end