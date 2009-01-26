module TicketSorter
  def mouse_clicked(event)
    scene.ticket_lister.show_these_tickets(sorted_tickets)
    toggle_sort_order
    clear_sort_images
  end
  
  private
  
  def type
    scene.find("ticket_type").value
  end
  
  def sorted_tickets
    tickets = scene.ticket_master.get_tickets(type)
    ascending_tickets = []
    if self.id == "title_header"
      ascending_tickets = tickets.sort_by { |ticket| ticket.title.downcase }
    elsif self.id == "state_header"
      ascending_tickets = tickets.sort_by { |ticket| ticket.state.downcase }
    elsif self.id == "assigned_user_header"
      ascending_tickets = tickets.sort_by { |ticket| ticket.assigned_user_name.to_s.downcase }
    else
      ascending_tickets = tickets.sort_by { |ticket| ticket.age }
    end
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
  
  def clear_sort_images
    scene.find("title_image").style.background_image = ""
    scene.find("state_image").style.background_image = ""
    scene.find("age_image").style.background_image = ""
    scene.find("user_image").style.background_image = ""
  end
end