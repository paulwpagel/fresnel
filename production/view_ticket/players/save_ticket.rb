module SaveTicket
  def button_pressed(event)
    current_ticket .title = new_title
    current_ticket.state = new_state
    current_ticket.save
  end
  
  def current_ticket
    return production.current_ticket
  end
  
  def new_title
    return scene.find("ticket_title").text
  end
  
  def new_state
    return scene.find("ticket_state").value
  end
end