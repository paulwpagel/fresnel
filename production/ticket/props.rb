main {
  __install "common/title_bar.rb"
  row {
    combo_box :id => "ticket_type", :players => "type_selector", :choices => ["Open Tickets", "All Tickets"]
  }
}