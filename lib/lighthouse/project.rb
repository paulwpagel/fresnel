require "lighthouse/ticket"

module Lighthouse
  class Project
    def open_tickets
      return Lighthouse::Ticket.find(:all, :params => {:project_id => self.id, :q => "state:open"})
    end
  end
end