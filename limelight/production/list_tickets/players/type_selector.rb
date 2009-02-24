module TypeSelector  
  def value_changed(event)
    notify_ticket_master
  end
  
  def notify_ticket_master
    scene.ticket_master.show_tickets(value)
  end
end