main {
  create_milestone_form {
    input_group {
      label :text => "Title"
      text_box :id => "new_milestone_title"
    }
    button :id => "create_milestone", :text => "Create Milestone", :players => "create_milestone", :width => 200
  }
}