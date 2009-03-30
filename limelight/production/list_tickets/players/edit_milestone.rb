module EditMilestone
  def mouse_clicked(event)
    edit
  end
  
  def edit
    scene.build(:milestone_id => milestone_id) do
      __install "list_tickets/edit_milestone_props.rb"
    end
  end
  
  private
  
  def milestone_id
    id.split('_')[-1].to_i
  end
end