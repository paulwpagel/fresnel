configure_milestones_wrapper(:id => "configure_milestones_wrapper") {
  create_milestone_form {
    input_group {
      label :text => "Title"
      text_box :id => "new_milestone_title"
    }
    input_group {
      label :text => "Due Date (DD-MM-YYYY)"
      text_box :id => "new_milestone_due_on"
    }
    input_group {
      label :text => "Goals"
      text_area :id => "new_milestone_goals"
    }
    button :id => "create_milestone", :text => "Create Milestone", :players => "create_milestone", :width => 200
  }
  
  existing_milestones {
    __install "list_tickets/existing_milestone_list.rb", :milestones => @milestones
  }
  
  button :id => "close_configure_milestones", :text => "Close", :players => "close_configure_milestones"
}