module TicketSorter
  def mouse_clicked(event)
    scene.ticket_master.get_tickets(type)
  end
  
  private
  
  def type
    scene.find("ticket_type").value
  end
end