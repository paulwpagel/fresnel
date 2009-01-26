main {
  __install "common/title_bar.rb"
  search_bar {
    label :text => "Search"
    search_box :players => "text_box", :name => "search_box",  :id => "search_box"
    button :players => "search", :id => "search_button", :text => "Search"
  }
  
  ticket_table {
    header_row {
      label :id => "title_header", :text => "Title", :name => "title_header", :players => "ticket_sorter"
      label :id => "state_header", :text => "State", :name => "state_header", :players => "ticket_sorter"
      label :id => "age_header", :text => "Last Activity", :name => "age_header", :players => "ticket_sorter"
      label :id => "assigned_user_header", :text => "Assigned User", :name => "assigned_user_header", :players => "ticket_sorter"
    }
    ticket_lister :id => "ticket_lister"
  }
  
  combo_box :id => "ticket_type", :players => "type_selector", :choices => ["Open Tickets", "All Tickets"], :width => 150
}