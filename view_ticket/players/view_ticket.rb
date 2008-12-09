module ViewTicket
  
  def scene_opened(event)
    unless $testing
      load_current_ticket
    end
  end
  
  def load_current_ticket
    prop = Limelight::Prop.new(:text => current_ticket.title)
    scene.find_by_name('main')[0].add(prop)
  end
  
  private
  
  def current_ticket
    return production.current_ticket
  end
end