require "lighthouse/ticket"

module Lighthouse
  class Project
    def open_tickets
      return Lighthouse::Ticket.find(:all, :params => {:project_id => self.id, :q => "state:open"})
    end
  
    def all_tickets
      return Lighthouse::Ticket.find(:all, :params => {:project_id => self.id, :q => "all"})
    end
    
    def milestone_titles
      return self.milestones.collect { |milestone| milestone.title }
    end
  end
end