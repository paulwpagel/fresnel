configure_milestones_wrapper(:id => "configure_milestones_wrapper") {
  configure_milestones_header(:height => "10%", :vertical_alignment => :center) {
    label :text => "Milestone Setup", :font_size => 36, :width => "100%", :horizontal_alignment => :center
  }
  configure_milestones_content(:height => "80%", :vertical_alignment => :center) {
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
  
    existing_milestones(:id => "existing_milestones") {
      __install "list_tickets/existing_milestone_list.rb", :milestones => @milestones
    }
  
  }
  back_button(:width => "100%", :horizontal_alignment => :right, :padding => 15, :height => "10%") {
    button :id => "close_configure_milestones", :text => "Back to Tickets", :players => "close_configure_milestones", :width => 150
  }
}