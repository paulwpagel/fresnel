milestone_header_row {
 heading :text => "Edit Existing Milestones"
}
@milestones.each do |milestone|
  edit_milestone_row {
    edit_milestone(:id => "edit_milestone_#{milestone.id}") {
      existing_milestone :text => milestone.title
    }
  }
end