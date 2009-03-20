module AddTicket
  prop_reader :add_ticket_title, :ticket_lister, :add_ticket_group, :add_ticket_description, :add_ticket_responsible_person, :add_ticket_tags, :add_ticket_milestone
  
  def button_pressed(event)
    show_spinner {add}
  end
  
  def add
      ticket_options = {}
      
      ticket_options[:title] = add_ticket_title.text
      ticket_options[:description] = add_ticket_description.text
      ticket_options[:assigned_user] = add_ticket_responsible_person.text
      ticket_options[:tags] = add_ticket_tags.text
      ticket_options[:milestone] = add_ticket_milestone.text
        
      project = stage_info.current_project

      stage_info.client.add_ticket(ticket_options, project)

      add_ticket_group.remove_all

      project.update_tickets
      ticket_lister.filter_by_type("Open Tickets")
  end
  
  private ###########################
  
  def stage_info
    return production.stage_manager[scene.stage.name]
  end
end
