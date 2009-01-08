module SaveTicket
  def button_pressed(event)
    current_ticket.title = new_title
    current_ticket.state = new_state
    current_ticket.milestone_id = new_milestone_id
    current_ticket.new_comment = new_comment
    current_ticket.assigned_user_id = new_assigned_user_id
    current_ticket.save
    scene.load('view_ticket')
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
end