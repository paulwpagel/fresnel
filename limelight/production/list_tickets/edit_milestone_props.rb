edit_milestone_wrapper {
  row {
    label :text => "Title:", :width => 100
    text_box :id => "milestone_title_#{@milestone.id}", :text => @milestone.title, :width => 250
  }
  row {
    label :text => "Goals:", :width => 100
    text_area :id => "milestone_goals_#{@milestone.id}", :text => @milestone.goals, :width => 250
  }
  row {
    label :text => "Due Date (DD-MM-YYYY):", :width => 100
    if @milestone.due_on
      text_box :id => "milestone_due_on_#{@milestone.id}", :text => "#{@milestone.due_on.day}-#{@milestone.due_on.month}-#{@milestone.due_on.year}", :width => 250
    else
      text_box :id => "milestone_due_on_#{@milestone.id}", :text => "", :width => 250
    end
  }
  row {
    delete_milestone :id => "delete_milestone_#{@milestone.id}"
    button :id => "save_milestone_#{@milestone.id}", :players => "save_milestone", :text => "Save"
    button :id => "cancel_edit_milestone_#{@milestone.id}", :players => "cancel_edit_milestone", :text => "Cancel"
  }
}