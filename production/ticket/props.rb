main {
  __install "common/title_bar.rb"
  row {
    combo_box :id => "sort_tickets", :players => "list_ticket", :choices => ["Open Tickets", "All Tickets"]
  }
}