module CancelAddTicket  
  def button_pressed event
    show_spinner do
      scene.find("add_ticket_group").remove_all
    end
  end
end