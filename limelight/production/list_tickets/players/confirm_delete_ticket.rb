module ConfirmDeleteTicket

  attr_accessor :id
  prop_reader :delete_ticket_confirmation_main, :ticket_lister

  def mouse_clicked(event)
    show_spinner { confirm_delete }
  end

  def confirm_delete
    scene.remove(delete_ticket_confirmation_main)
    stage_info.current_project.destroy_ticket(ticket_id)
    stage_info.current_ticket = nil if current_ticket?(ticket_id)
    ticket_lister.remove_ticket(ticket_id)
  end
  
  private ##############################
  
  def stage_info
    return production.stage_manager[scene.stage.name]
  end
  
  def current_ticket?(ticket_id)
    return current_ticket && current_ticket.id == ticket_id
  end
  
  def current_ticket
    return stage_info.current_ticket
  end
  
  def ticket_id
    return id.sub("confirm_delete_ticket_", "").to_i
  end
end