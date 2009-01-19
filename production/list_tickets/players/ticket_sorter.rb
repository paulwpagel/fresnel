module TicketSorter
  def mouse_clicked(event)
    scene.ticket_lister.show_these_tickets(sorted_tickets)
    toggle_sort_order
  end
  
  private
  
  def type
    scene.find("ticket_type").value
  end
  
  def sorted_tickets
    tickets = scene.ticket_master.get_tickets(type)
    ascending_tickets = tickets.sort_by { |ticket| ticket.send(attribute).downcase }
    return ascending_tickets.reverse if production.current_sort_order == "ascending"
    return ascending_tickets
  end
  
  def toggle_sort_order
    if production.current_sort_order == "ascending"
      production.current_sort_order = "descending"
    else
      production.current_sort_order = "ascending"
    end
  end
  
  private
  
  def attribute
    if self.id == "title_header"
      return :title
    else
      return :state
    end
  end
end