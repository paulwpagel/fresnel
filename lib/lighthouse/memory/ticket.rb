module Lighthouse
  module Memory
    class Ticket
      def self.find_tickets(project_id, query)
        return []
      end

      attr_reader :id
      attr_accessor :status, :title, :milestone_id, :project_id, :description
      alias :state :status
      
      def initialize(options = {})
        @title = options[:title]
        @status = options[:status]
        @milestone_id = options[:milestone_id]
        @id = options[:id]
        @project_id = options[:project_id]
        @description = options[:description]
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
