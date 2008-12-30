module SaveTicket
  def button_pressed(event)
    production.current_ticket.title = new_title
    production.current_ticket.save
  end
  
  def new_title
    scene.find("ticket_title").text
  end
end