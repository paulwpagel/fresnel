module Lighthouse
  module Memory
    class Project
      attr_accessor :tickets
  
      def initialize
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
