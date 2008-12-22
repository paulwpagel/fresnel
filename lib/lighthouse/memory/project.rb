require "lighthouse/memory/ticket"
module Lighthouse
  module Memory
    class Project
      attr_accessor :tickets, :name
  
      def initialize(options = {})
        @name = options[:name]
        @tickets = []
      end
  
      def open_tickets
        return []
      end
  
      def all_tickets
        return []
      end
    end
  end
end
