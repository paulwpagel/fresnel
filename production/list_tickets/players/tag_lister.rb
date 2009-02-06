module TagLister
  def show_project_tags
    remove_all
    project.tag_names.each_with_index do |tag, index|
      scene.tag_lister.add(Limelight::Prop.new(:name => "tag", :text => tag, :id => "tag_#{index + 1}"))
    end
  end
  
  private ####################################
  
  def project
    production.current_project
  end
end