module EditMilestone
  def mouse_clicked(event)
    edit unless scene.find("save_milestone_#{milestone_id}")
  end
  
  def edit
    remove_all
    build(:milestone => current_project.milestone_from_id(milestone_id)) do
      __install "list_tickets/edit_milestone_props.rb", :milestone => @milestone
    end
  end
  
  private
  
  def current_project
    return production.stage_manager[scene.stage.name].current_project
  end
  
  def milestone_id
    id.split('_')[-1].to_i
  end
end