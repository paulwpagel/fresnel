module Lighthouse
  module Memory
    class Ticket
      attr_reader :title, :description, :status
      
      def initialize(options = {})
        @title = options[:title]
        @description = options[:description]
        @status = options[:status]
        @milestone_id = options[:milestone_id]
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
