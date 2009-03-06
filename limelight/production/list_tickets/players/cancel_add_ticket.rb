module CancelAddTicket  
  def button_pressed event
    show_spinner {cancel}
  end
  
  def cancel
    scene.remove_children_of "add_ticket_group"
  end
end