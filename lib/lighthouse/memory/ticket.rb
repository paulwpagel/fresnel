module Lighthouse
  module Memory
    class Ticket
      def self.find_tickets(project_id, query)
        return []
      end
      
      attr_reader :title, :description, :status, :id
      alias :state :status
      
      def initialize(options = {})
        @title = options[:title]
        @description = options[:description]
        @status = options[:status]
        @milestone_id = options[:milestone_id]
        @id = options[:id]
      end
      
      def milestone(project)
        project.milestones.each do |milestone| 
          return milestone if milestone.id == @milestone_id
        end
        return nil
      end
    end
  end
end
