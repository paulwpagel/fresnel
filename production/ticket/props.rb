main {
  __install "common/title_bar.rb"
  row {
    ticket_lister :id => "ticket_lister"
    combo_box :id => "ticket_type", :players => "type_selector", :choices => ["Open Tickets", "All Tickets"]
  }
}