class TicketMaster

  def initialize(scene)
    @scene = scene
  end
  
  def matching_tickets(attributes)
    return project.tickets_for_type(attributes[:type]) if attributes[:tag].nil?
    return project.tickets_for_tag(attributes[:tag]) if attributes[:type].nil?
    return project.tickets_for_tag(attributes[:tag]) & project.tickets_for_type(attributes[:type])
  end
  
  private ##############################
  
  def project
    return @scene.production.stage_manager[@scene.stage.name].current_project
  end
  
end