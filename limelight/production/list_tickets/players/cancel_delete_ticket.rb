module CancelDeleteTicket
  
  prop_reader :delete_ticket_confirmation_main

  def mouse_clicked(event)
    cancel
  end
  
  def cancel
    scene.remove(delete_ticket_confirmation_main)
  end
end