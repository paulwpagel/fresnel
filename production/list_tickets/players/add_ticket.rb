


module AddTicket

  def button_pressed(event)
    title = scene.find("add_ticket_title")
    description = scene.find("add_ticket_description")
    responsible_person = scene.find("add_ticket_responsible_person")
    tags = scene.find("add_ticket_tags")
    milestone = scene.find("add_ticket_milestone")
    
    ticket_options = {}
    ticket_options[:title] = title.text 
    ticket_options[:description] = description.text
    ticket_options[:assigned_user_id] = production.current_project.user_id(responsible_person.text)
    ticket_options[:tags] = tags.text
    ticket_options[:milestone_id] = production.current_project.milestone_id(milestone.text)
  
    production.lighthouse_client.add_ticket(ticket_options, production.current_project)
    
  end
  
end
