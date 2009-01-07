require "lighthouse/memory/ticket"
require "lighthouse/memory/milestone"

module Lighthouse
  module Memory
    class Project
      attr_accessor :tickets, :name, :milestones, :id
  
      def initialize(options = {})
        @name = options[:name]
        @tickets = []
        @milestones = []
      end
  
      def open_tickets
        open = []
        @tickets.each {|ticket| open << ticket if ticket.status == "state:open"}
        return open
      end
  
      def all_tickets
        return @tickets
      end
      
      def milestone_titles
        return []
      end
    end
  end
end
