module EditMilestone
  def mouse_clicked(event)
    edit unless scene.find("save_milestone_#{milestone_id}")
  end
  
  def edit
    remove_all
    build(:milestone_id => milestone_id) do
      __install "list_tickets/edit_milestone_props.rb", :milestone_id => @milestone_id
    end
  end
  
  private
  
  def milestone_id
    id.split('_')[-1].to_i
  end
end