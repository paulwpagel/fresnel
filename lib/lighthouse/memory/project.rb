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
        return @milestones.collect {|milestone| milestone.title}
      end
      
      def milestone_title(id)
        return milestone_from_id(id).title if milestone_from_id(id)
      end
      
      def milestone_id(title)
        return milestone_from_title(title).id if milestone_from_title(title)
      end
      
      def open_states
        return ["new", "open"]
      end
      
      def closed_states
        return ["resolved", "hold", "invalid"]
      end
      
      def all_states
        return open_states + closed_states
      end
      
      private
      
      def milestone_from_id(id)
        return @milestones.find { |milestone| milestone.id == id }
      end
      
      def milestone_from_title(title)
        return @milestones.find { |milestone| milestone.title == title }
      end
    end
  end
end
