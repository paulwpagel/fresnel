

module CancelAddTicket
  
  def button_pressed event
    scene.ticket_lister.remove(scene.find("add_ticket_group"))
  end
end