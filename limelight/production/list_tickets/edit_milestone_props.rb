edit_milestone_wrapper {
  text_box :id => "milestone_title_#{@milestone_id}"
  button :id => "save_milestone_#{@milestone_id}", :players => "save_milestone", :text => "Save"
}