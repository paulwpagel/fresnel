module DeleteTicket
  
  def mouse_clicked(event)
    scene.build(:ticket_id => ticket_id) do
      delete_ticket_confirmation_main(:id => "delete_ticket_confirmation_main") {
        delete_ticket_confirmation_box {
          delete_ticket_button :text => "Delete", :id => "confirm_delete_ticket_#{@ticket_id}", :players => "confirm_delete_ticket"
          delete_ticket_button :text => "Cancel", :id => "cancel_delete_ticket_#{@ticket_id}", :players => "cancel_delete_ticket"
        }
      }
    end
  end
  
  private #################################
  
  def ticket_id
    return id.sub("delete_ticket_", "").to_i
  end
  
end