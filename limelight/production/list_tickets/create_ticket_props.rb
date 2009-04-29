main_ticket_group {
  input_group {
    add_ticket_label :text => "Title:"
    input :players => "text_box", :id => "add_ticket_title", :width => 300
  }
  input_group {
    add_ticket_label :text => "Description:"
    input :players => "text_area", :id => "add_ticket_description", :width => 300
  }

  input_group{
    add_ticket_label :text => "Milestone:"
    combo_box :id => 'add_ticket_milestone', :choices => @milestone_choices, :width => 300
  }

  input_group{
    add_ticket_label :text => "Who's Responsible:"
    combo_box :id => 'add_ticket_responsible_person', :choices => @assigned_user_choices, :width => 300
  }

  input_group{
    add_ticket_label :text => "Tags:"
    text_box :id => 'add_ticket_tags', :width => 300
  }

  button :text => "Add", :players => "add_ticket", :width => 125, :id => "submit_add_ticket_button"
  button :text => "Cancel", :players => "cancel_add_ticket", :width => 125, :id => "cancel_add_ticket_button"
}