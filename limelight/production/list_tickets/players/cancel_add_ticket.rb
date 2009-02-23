module CancelAddTicket  
  def button_pressed event
    scene.find("add_ticket_group").remove_all
  end
end