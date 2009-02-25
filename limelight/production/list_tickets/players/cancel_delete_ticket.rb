module CancelDeleteTicket
  def mouse_clicked(event)
    scene.remove(scene.find("delete_ticket_confirmation_main"))
  end
end