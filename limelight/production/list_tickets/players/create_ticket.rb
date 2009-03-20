module CreateTicket
  
  prop_reader :add_ticket_group, :add_ticket_milestone, :add_ticket_responsible_person
  
  def button_pressed(event)
    show_spinner { create_ticket }
  end
  
  def create_ticket
    add_ticket_group.build do
      __install "list_tickets/create_ticket_props.rb"
    end

    add_ticket_milestone.choices = ["None"] + current_project.milestone_titles
    add_ticket_responsible_person.choices = ["None"] + current_project.user_names
  end
  
  private ########################
  
  def current_project
    return production.stage_manager[scene.stage.name].current_project
  end
end