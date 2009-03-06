module AddTicket
  
  def button_pressed(event)
    
    show_spinner {add}
  end
  
  def add
      ticket_options = {}
      
      ticket_options[:title] = scene.text_for("add_ticket_title")
      ticket_options[:description] = scene.text_for("add_ticket_description")
      ticket_options[:assigned_user] = scene.text_for("add_ticket_responsible_person")
      ticket_options[:tags] = scene.text_for("add_ticket_tags")
      ticket_options[:milestone] = scene.text_for("add_ticket_milestone")
        
      project = production.current_project

      production.lighthouse_client.add_ticket(ticket_options, project)

      scene.remove_children_of("add_ticket_group")

      project.update_tickets
      scene.ticket_lister.filter_by_type("Open Tickets")
    
  end
  
end
