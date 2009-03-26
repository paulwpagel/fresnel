module TypeSelector  
  def value_changed(event)
    show_spinner do
      notify_ticket_lister if notify_ticket_lister?
    end
  end
  
  def notify_ticket_lister?
    return scene.ticket_lister && !scene.loading?
  end
  
  def notify_ticket_lister
    scene.ticket_lister.filter_by_type(value)
  end
end