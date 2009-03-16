main_ticket_group {
  input_group {
    label :text => "Title:"
    input :players => "text_box", :id => "add_ticket_title", :width => 200
  }
  input_group {
    label :text => "Description:"
    input :players => "text_box", :id => "add_ticket_description", :width => 200
  }

  input_group{
    label :text => "Milestone:"
    combo_box :id => 'add_ticket_milestone'
  }

  input_group{
    label :text => "Who's Responsible:"
    combo_box :id => 'add_ticket_responsible_person'
  }

  input_group{
    label :text => "Tags"
    text_box :id => 'add_ticket_tags'
  }

  button :text => "Add", :players => "add_ticket", :width => 125, :id => "submit_add_ticket_button"
  button :text => "Cancel", :players => "cancel_add_ticket", :width => 125, :id => "cancel_add_ticket_button"
}