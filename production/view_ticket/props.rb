main {
  __install 'common/title_bar.rb'
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
}