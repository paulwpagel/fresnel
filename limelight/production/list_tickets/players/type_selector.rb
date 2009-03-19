module TypeSelector  
  def value_changed(event)
    show_spinner(scene.stage.name) do
      notify_ticket_lister if scene.ticket_lister
    end
  end
  
  def notify_ticket_lister
    scene.ticket_lister.filter_by_type(value)
  end
end