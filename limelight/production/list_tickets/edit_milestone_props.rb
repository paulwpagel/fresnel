edit_milestone_wrapper {
  text_box :id => "milestone_title_#{@milestone.id}", :text => @milestone.title
  text_box :id => "milestone_goals_#{@milestone.id}", :text => @milestone.goals
  if @milestone.due_on
    text_box :id => "milestone_due_on_#{@milestone.id}", :text => "#{@milestone.due_on.month}-#{@milestone.due_on.day}-#{@milestone.due_on.year}"
  else
    text_box :id => "milestone_due_on_#{@milestone.id}", :text => ""
  end
  button :id => "save_milestone_#{@milestone.id}", :players => "save_milestone", :text => "Save"
}