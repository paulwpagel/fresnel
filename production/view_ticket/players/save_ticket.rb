module SaveTicket
  def button_pressed(event)
    production.current_ticket.milestone_id = milestone_id
    production.current_ticket.save
  end
  
  def milestone_id
    production.lighthouse_client.milestone_id_for_title(milestone_title)
  end
  
  def milestone_title
    scene.find("ticket_milestone").value
  end
end