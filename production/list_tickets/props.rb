main {
  __install "common/title_bar.rb"
  row {
    label :id => "title_header", :text => "Title", :name => "title_header", :players => "ticket_sorter"
    ticket_lister :id => "ticket_lister"
    combo_box :id => "ticket_type", :players => "type_selector", :choices => ["Open Tickets", "All Tickets"], :width => 150
  }
}