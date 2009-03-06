module AddTicket

  def button_pressed(event)
    show_spinner do
      ticket_options = {}
      ticket_options[:title] = scene.text_for("add_ticket_title")
      ticket_options[:description] = scene.text_for("add_ticket_description")
      ticket_options[:assigned_user_id] = production.current_project.user_id(scene.text_for("add_ticket_responsible_person"))
      ticket_options[:tags] = scene.text_for("add_ticket_tags")
      ticket_options[:milestone_id] = production.current_project.milestone_id(scene.text_for("add_ticket_milestone"))
  
      production.lighthouse_client.add_ticket(ticket_options, production.current_project)
    
      scene.find("add_ticket_group").remove_all
    
      production.current_project.update_tickets
      scene.ticket_lister.show_these_tickets(production.current_project.open_tickets)
    end
  end
  
end
