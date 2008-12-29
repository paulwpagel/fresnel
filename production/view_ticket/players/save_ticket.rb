module SaveTicket
  def button_pressed(event)
    production.current_ticket.milestone_title = milestone_title
    production.current_ticket.save
  end
  
  def milestone_title
    scene.find("ticket_milestone").value
  end
end