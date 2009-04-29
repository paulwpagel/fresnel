module EditTicket
  attr_accessor :id
  
  def mouse_clicked(event)
    show_spinner { edit } unless scene.find("save_button")
  end
  
  def edit
    stage_info.current_ticket = current_ticket
    remove_all
    build(:ticket => current_ticket, :project => stage_info.current_project) do
      __install "list_tickets/edit_ticket_props.rb", :ticket => @ticket, :project => @project
    end
  end
  
  private ###################
    
  def ticket_id
    return id.split("_")[1].to_i
  end
  
  def current_ticket
    return client.ticket(ticket_id, stage_info.current_project)
  end
  
  def client
    return production.stage_manager.client_for_stage(stage_name)
  end
  
  def stage_info
    return production.stage_manager[stage_name]
  end
  
  def stage_name
    return scene.stage.name
  end
end