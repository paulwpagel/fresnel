module TicketMaster
  def show_tickets(tickets)
    tickets.each do |ticket|  
      scene.find_by_name('main').first.add(prop_for(ticket))
    end
  end
  
  def prop_for(ticket)
    return Limelight::Prop.new(:id => "ticket_#{ticket.id}", :name => "ticket_in_list",
                                            :text => "#{ticket.title}, State: #{ticket.state}", :players => "ticket",
                                            :on_mouse_clicked => "view(#{ticket.id})")
  end
end