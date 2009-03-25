module CreateMilestone
  prop_reader :new_milestone_title
  
  def create
    production.stage_manager[scene.stage.name].current_project.create_milestone(:title => new_milestone_title.text)
  end
end