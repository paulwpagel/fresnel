module DeleteTicket
  attr_accessor :id
  def mouse_clicked(event)
    delete
  end
  
  def delete
    scene.build(:ticket_id => ticket_id, :ticket_title => current_project.ticket_title(ticket_id)) do
      __install "list_tickets/delete_ticket_props.rb", :ticket_id => @ticket_id, :ticket_title => @ticket_title
    end
  end
  
  private #################################
  
  def ticket_id
    return id.sub("delete_ticket_", "").to_i
  end
  
  def current_project
    return production.stage_manager[scene.stage.name].current_project
  end
end