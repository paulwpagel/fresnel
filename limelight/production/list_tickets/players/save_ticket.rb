module SaveTicket  
  prop_reader :ticket_lister, :ticket_title, :ticket_state, :ticket_tag, :ticket_milestone, :ticket_comment, :ticket_assigned_user
  
  def button_pressed(event)
    show_spinner {save_ticket}
  end
  
  def mouse_clicked(event)    
  end
  
  def save_ticket
    current_ticket.title = ticket_title.text
    current_ticket.state = ticket_state.value
    current_ticket.milestone_id = production.current_project.milestone_id(ticket_milestone.value)
    current_ticket.tag = ticket_tag.text
    current_ticket.new_comment = ticket_comment.text
    current_ticket.assigned_user_id = current_project.user_id(ticket_assigned_user.value)
    current_ticket.save
    
    production.current_ticket = production.lighthouse_client.ticket(current_ticket.id, current_project)
    ticket_lister.show_these_tickets(current_project.open_tickets)
  end
  
  private #***********************
  
  def current_ticket
    return production.current_ticket
  end
  
  def current_project
    return production.current_project
  end
end