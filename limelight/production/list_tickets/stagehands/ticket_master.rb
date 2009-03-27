class TicketMaster

  def initialize(scene)
    @scene = scene
  end
  
  def matching_tickets(attributes)
    found_tickets = project.all_tickets
    attributes.each_pair do |attribute, value|
      begin
        found_tickets = found_tickets & project.send("tickets_for_#{attribute}", value) if value
      rescue NoMethodError
      end
    end
    return found_tickets
  end
  
  private ##############################
  
  def project
    return @scene.production.stage_manager[@scene.stage.name].current_project
  end
  
end