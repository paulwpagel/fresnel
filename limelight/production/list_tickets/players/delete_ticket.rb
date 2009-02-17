module DeleteTicket
  def mouse_clicked(event)
    production.current_project.destroy_ticket(ticket_id)
    production.current_ticket = nil if current_ticket.id == ticket_id
    scene.ticket_lister.remove_ticket(ticket_id)
  end
  
  private ##############################
  
  def current_ticket
    return production.current_ticket
  end
  
  def ticket_id
    return id.sub("delete_ticket_", "").to_i
  end
end