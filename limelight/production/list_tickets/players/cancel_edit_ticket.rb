
module CancelEditTicket
  
  prop_reader :ticket_lister
  def button_pressed(event)
    show_spinner { cancel }
  end
  
  def mouse_clicked(event)
  end
  
  def cancel
    ticket_lister.cancel_edit_ticket
  end
end