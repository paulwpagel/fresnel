module ConfigureMilestones
  def mouse_clicked(event)
    show_spinner { open_milestones }
  end
  
  def open_milestones
    scene.build do
      __install "list_tickets/configure_milestones_props.rb"
    end
  end
end