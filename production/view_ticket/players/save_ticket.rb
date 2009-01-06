module SaveTicket
  def button_pressed(event)
    current_ticket.title = new_title
    current_ticket.state = new_state
    current_ticket.milestone_id = new_milestone_id
    current_ticket.new_comment = new_comment
    current_ticket.save
  end
  
  def current_ticket
    return production.current_ticket
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