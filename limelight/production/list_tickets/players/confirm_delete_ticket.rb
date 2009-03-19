module ConfirmDeleteTicket

  attr_accessor :id
  prop_reader :delete_ticket_confirmation_main, :ticket_lister

  def mouse_clicked(event)
    show_spinner(scene.stage.name) { confirm_delete }
  end

  
  def confirm_delete
    scene.remove(delete_ticket_confirmation_main)
    production.current_project.destroy_ticket(ticket_id)
    production.current_ticket = nil if current_ticket?(ticket_id)
    ticket_lister.remove_ticket(ticket_id)
  end
  
  private ##############################
  
  def current_ticket?(ticket_id)
    return current_ticket && current_ticket.id == ticket_id
  end
  
  def current_ticket
    return production.current_ticket
  end
  
  def ticket_id
    return id.sub("confirm_delete_ticket_", "").to_i
  end
end