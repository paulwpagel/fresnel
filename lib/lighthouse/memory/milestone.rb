
module Lighthouse
  module Memory
    class Milestone
      attr_reader :title

      def initialize(options = {})
        @title = options[:title]
      end
      
    end
  end
end