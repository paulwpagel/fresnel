module ConfigureMilestones
  def mouse_clicked(event)
    show_spinner { open_milestones }
  end
  
  def open_milestones
    scene.build(:milestones => current_project.milestones) do
      __install "list_tickets/configure_milestones_props.rb"
    end
  end
  
  private #####################
  
  def current_project
    production.stage_manager[scene.stage.name].current_project
  end
end