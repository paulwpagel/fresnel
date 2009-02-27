# require File.expand_path(File.dirname(__FILE__) + "/../stagehands/converts_ticket_to_prop")

module CancelEditTicket
  def button_pressed(event)
    show_spinner do
      scene.ticket_lister.cancel_edit_ticket
    end
  end
  
  def mouse_clicked(event)
  end
end