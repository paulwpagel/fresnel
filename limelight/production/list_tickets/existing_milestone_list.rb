existing_milestones_header :text => "Edit Existing Milestones"
@milestones.each do |milestone|
  row {
    edit_milestone(:id => "edit_milestone_#{milestone.id}") {
      existing_milestone :text => milestone.title
    }
  }
end