module TicketSorter
  def mouse_clicked(event)
    scene.ticket_lister.show_these_tickets(sorted_tickets)
  end
  
  private
  
  def type
    scene.find("ticket_type").value
  end
  
  def sorted_tickets
    tickets = scene.ticket_master.get_tickets(type)
    sorted_tickets = tickets.sort_by { |ticket| ticket.title }
  end
end