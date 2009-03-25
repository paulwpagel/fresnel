main {
  button :id => "back_button", :text => "View Tickets", :on_button_pressed => "scene.load('list_tickets')"
  create_milestone_form {
    input_group {
      label :text => "Title"
      text_box :id => "new_milestone_title"
    }
    input_group {
      label :text => "Due Date (MM-DD-YYYY)"
      text_box :id => "new_milestone_due_on"
    }
    input_group {
      label :text => "Goals"
      text_area :id => "new_milestone_goals"
    }
    button :id => "create_milestone", :text => "Create Milestone", :players => "create_milestone", :width => 200
  }
}