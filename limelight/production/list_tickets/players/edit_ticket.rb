module EditTicket
  attr_accessor :id
  
  def mouse_clicked(event)
    show_spinner { edit }
  end
  
  def edit
    production.current_ticket = production.lighthouse_client.ticket(ticket_id, production.current_project)
    remove_all
    build(:ticket => production.current_ticket, :project => production.current_project) do
      __install "list_tickets/edit_ticket_props.rb", :ticket => @ticket, :project => @project
    end
    hover_style.background_color = "5A9ECF"
  end
  
  private ###################
    
  def ticket_id
    return id.split("_")[1].to_i
  end
end