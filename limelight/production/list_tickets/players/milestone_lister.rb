module MilestoneLister

  def observe
    list_titles
  end
  
  def activate(id)
    if id
      milestone = scene.find(id)
      list_titles milestone.text
    else
      list_titles
    end
  end
  
  def list_titles(active_milestone_text = nil)
    remove_all
    
    add(Limelight::Prop.new(:name => "milestone", :text => "All Milestones"))
    
    project.milestone_titles.each_with_index do |milestone_text, index|
      name = "milestone"
      name = "active_milestone" if active_milestone_text == milestone_text
      add(Limelight::Prop.new(:name => name, :text => milestone_text, :id => "milestone_#{index + 1}"))
    end
  end
  
  private ####################################
  
  def project
    return production.stage_manager[stage_name].current_project
  end
  
  def stage_name
    return scene.stage.name
  end
end