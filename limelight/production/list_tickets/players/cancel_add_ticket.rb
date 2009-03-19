module CancelAddTicket  
  def button_pressed event
    show_spinner(scene.stage.name) {cancel}
  end
  
  def cancel
    scene.remove_children_of "add_ticket_group"
  end
end