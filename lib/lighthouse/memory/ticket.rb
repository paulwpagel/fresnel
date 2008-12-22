module Lighthouse
  module Memory
    class Ticket
      attr_reader :title, :description
      def initialize(options = {})
        @title ||= options[:title]
        @description ||= options[:description]
      end
    end
  end
end
