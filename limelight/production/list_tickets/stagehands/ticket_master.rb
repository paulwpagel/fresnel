class TicketMaster

  def initialize(scene)
    @scene = scene
  end
  
  def tickets_for_type_and_tag(type, tag)
    return project.tickets_for_type(type) if tag.nil?
    return project.tickets_for_tag(tag) if type.nil?
    return project.tickets_for_tag(tag) & project.tickets_for_type(type)
  end
  
  private ##############################
  
  def project
    return @scene.production.stage_manager[@scene.stage.name].current_project
  end
  
end