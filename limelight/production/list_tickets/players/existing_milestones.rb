module ExistingMilestones
  def refresh
    remove_all
    build(:milestones => milestones) do
      __install "list_tickets/existing_milestone_list.rb", :milestones => @milestones
    end
  end
  
  private ###########################
  
  def milestones
    return production.stage_manager[scene.stage.name].current_project.milestones
  end
  
end