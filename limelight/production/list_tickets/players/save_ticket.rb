module SaveTicket  

  def button_pressed(event)
    show_spinner do
      update_ticket
      save_current_ticket_in_production
      scene.ticket_lister.show_these_tickets(current_project.open_tickets)
    end
  end
  
  def mouse_clicked(event)    
  end
  
  private #***********************
  
  def update_ticket
    current_ticket.title = scene.text_for("ticket_title")
    current_ticket.state = value_for("ticket_state")
    current_ticket.milestone_id = production.current_project.milestone_id(value_for("ticket_milestone"))
    current_ticket.new_comment = scene.text_for("ticket_comment")
    current_ticket.assigned_user_id = new_assigned_user_id
    current_ticket.tag = scene.text_for("ticket_tag")
    current_ticket.save
  end
  
  def save_current_ticket_in_production
    production.current_ticket = production.lighthouse_client.ticket(current_ticket.id, current_project)
  end
  
  def current_ticket
    return production.current_ticket
  end
  
  def current_project
    return production.current_project
  end
  
  def new_assigned_user_id
    return current_project.user_id(value_for("ticket_assigned_user"))
  end
  
  def value_for(id)
    return scene.find(id).value
  end
end