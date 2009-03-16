delete_ticket_confirmation_main(:id => "delete_ticket_confirmation_main") {
  delete_ticket_confirmation_box {
    delete_ticket_confirmation_message :text => "Are you sure you want to delete \"#{@ticket_title}\"", :id => "delete_ticket_confirmation_message"
    delete_ticket_button :text => "Delete", :id => "confirm_delete_ticket_#{@ticket_id}", :players => "confirm_delete_ticket"
    delete_ticket_button :text => "Cancel", :id => "cancel_delete_ticket_#{@ticket_id}", :players => "cancel_delete_ticket"
  }
}
