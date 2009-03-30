edit_milestone_wrapper {
  text_box :id => "milestone_title_#{@milestone.id}", :text => @milestone.title
  button :id => "save_milestone_#{@milestone.id}", :players => "save_milestone", :text => "Save"
}