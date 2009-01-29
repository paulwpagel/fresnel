main {
  __install "common/title_bar.rb"
  search_bar {
    combo_box :id => "ticket_type", :players => "type_selector", :choices => ["Open Tickets", "All Tickets"], :width => 350, :right_margin => 200
    label :text => "Search", :font_size => 14, :width => 70
    search_box :players => "text_box", :name => "search_box",  :id => "search_box"
    button :players => "search", :id => "search_button", :text => "Search"
  }
  
  ticket_table {
    header_row {
      header_cell {
        label :id => "title_header", :text => "Title", :name => "title_header", :players => "ticket_sorter"
        sort_image :id => "title_image"
      }
      header_cell {
        label :id => "state_header", :text => "State", :name => "state_header", :players => "ticket_sorter"
        sort_image :id => "state_image"
      }
      header_cell {
        label :id => "age_header", :text => "Last Activity", :name => "age_header", :players => "ticket_sorter"
        sort_image :id => "age_image"
      }
      header_cell {
        label :id => "assigned_user_header", :text => "Assigned User", :name => "assigned_user_header", :players => "ticket_sorter"
        sort_image :id => "assigned_user_image"
      }
    }
    ticket_lister :id => "ticket_lister"
  }
  tags(:id => "tags") {}
}