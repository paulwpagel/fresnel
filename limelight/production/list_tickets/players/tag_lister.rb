module TagLister

  def show_project_tags
    remove_all
    list_tags
  end
  
  def activate(id)
    tag = scene.find(id)
    remove_all
    list_tags tag.text
  end
  
  def list_tags(active_tag_text = nil)
    project.tag_names.each_with_index do |tag_text, index|
      name = "tag"
      name = "active_tag" if active_tag_text == tag_text
      add(Limelight::Prop.new(:name => name, :text => tag_text, :id => "tag_#{index + 1}"))
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