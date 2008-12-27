
module Lighthouse
  module Memory
    class Milestone
      attr_reader :title, :id

      def initialize(options = {})
        @title = options[:title]
        @id = options[:id]
      end
      
    end
  end
end