module CancelAddTicket
  prop_reader :add_ticket_group
  
  def button_pressed event
    show_spinner {cancel}
  end
  
  def cancel
    add_ticket_group.remove_all
  end
end