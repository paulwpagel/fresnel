module SaveTicket
  
  def button_pressed(event)
    update_ticket
    save_current_ticket_in_production
    scene.ticket_lister.show_these_tickets(current_project.open_tickets)
  end
  
  def mouse_clicked(event)    
  end
  
  private #***********************
  
  def update_ticket
    current_ticket.title = new_title
    current_ticket.state = new_state
    current_ticket.milestone_id = new_milestone_id
    current_ticket.new_comment = new_comment
    current_ticket.assigned_user_id = new_assigned_user_id
    current_ticket.tag = new_tag
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
    return current_project.user_id(new_assigned_user_name)
  end
  
  def new_assigned_user_name
    return scene.find("ticket_assigned_user").value
  end
  
  def new_comment
    return scene.find("ticket_comment").text
  end
  
  def new_milestone_id
    return production.current_project.milestone_id(new_milestone_title)
  end
  
  def new_milestone_title
    return scene.find("ticket_milestone").value
  end
  
  def new_title
    return scene.find("ticket_title").text
  end
  
  def new_state
    return scene.find("ticket_state").value
  end
  
  def new_tag
    return scene.find("ticket_tag").text
  end
end