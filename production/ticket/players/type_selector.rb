module TypeSelector
  def value_changed(event)
    scene.ticket_master.show_tickets(value)
  end
end