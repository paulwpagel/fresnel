main {
  row {
    button :text => "Save Ticket", :id => "save_button", :players => "save_ticket"
  }
  row {
    cell {
      text_box :id => "ticket_title", :width => 250
    }
    cell {
      combo_box :id => "ticket_state"
    }
  }
  row {
    label :text => "Tags:"
    text_box :id => "ticket_tag", :width => 350
  }
}