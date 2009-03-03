module TypeSelector  
  def value_changed(event)
    show_spinner do
      notify_ticket_master
    end
  end
  
  def notify_ticket_master
    scene.ticket_master.filter_by_type(value)
  end
end