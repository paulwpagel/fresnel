
module CancelSaveTicket
  prop_reader :ticket_lister
  
  def button_pressed(event)
    TicketMaster.new(self).show_tickets("Open Tickets")
  end
  
  def ticket_master
    
  end
end