module TicketSorter
  def mouse_clicked(event)
    show_spinner(scene.stage.name) do
      scene.ticket_lister.show_these_tickets(sorted_tickets)
      toggle_sort_order
      clear_sort_images
      set_new_image
    end
  end
  
  private
  
  def sorted_tickets
    tickets = scene.ticket_lister.last_tickets
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
    scene.find("assigned_user_image").style.background_image = ""
  end
  
  def set_new_image
    image_name = self.id.sub(/header/, "image")
    scene.find(image_name).style.background_image = "images/#{production.current_sort_order}.png"
  end
end