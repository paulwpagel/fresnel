module TypeSelector  
  def value_changed(event)
    show_spinner do
      notify_ticket_master
    end
  end
  
  def notify_ticket_master
    scene.ticket_master.show_tickets(value)
  end
end