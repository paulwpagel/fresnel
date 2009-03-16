
module CancelEditTicket
  
  prop_reader :ticket_lister
  def button_pressed(event)
    show_spinner do
      cancel
    end
  end
  
  def mouse_clicked(event)
  end
  
  def cancel
    ticket_lister.cancel_edit_ticket
  end
end