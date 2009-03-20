module EditTicket
  attr_accessor :id
  
  def mouse_clicked(event)
    show_spinner { edit }
  end
  
  def edit
    stage_info.current_ticket = current_ticket
    remove_all
    build(:ticket => current_ticket, :project => stage_info.current_project) do
      __install "list_tickets/edit_ticket_props.rb", :ticket => @ticket, :project => @project
    end
    hover_style.background_color = "5A9ECF"
  end
  
  private ###################
    
  def ticket_id
    return id.split("_")[1].to_i
  end
  
  def current_ticket
    return stage_info.client.ticket(ticket_id, stage_info.current_project)
  end
  
  def stage_info
    return production.stage_manager[scene.stage.name]
  end
end