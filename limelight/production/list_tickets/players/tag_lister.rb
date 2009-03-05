module TagLister

  def show_project_tags
    build_tags
  end
  
  def activate(id)
    tag = scene.find(id)
    build_tags tag.text
  end
  
  private ####################################
  
  def build_tags(active_tag_text=nil)
    remove_all
    project.tag_names.each_with_index do |tag_text, index|
      name = (active_tag_text == tag_text) ? 
                              "active_tag" :
                              "tag"
      scene.tag_lister.add(Limelight::Prop.new(:name => name, :text => tag_text, :id => "tag_#{index + 1}"))
    end
  end
  
  def project
    production.current_project
  end
end