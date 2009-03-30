@milestones.each do |milestone|
  row {
    edit_milestone(:id => "edit_milestone_#{milestone.id}") {
      label :text => milestone.title
    }
  }
end