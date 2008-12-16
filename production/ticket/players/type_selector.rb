module TypeSelector
  def value_changed(event)
    unless $testing
      notify_ticket_master
    end
  end
  
  def notify_ticket_master
    scene.ticket_master.show_tickets(value)
  end
end