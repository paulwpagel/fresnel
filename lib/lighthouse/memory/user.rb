module Lighthouse
  module Memory
    class User
      attr_accessor :name, :id
      def initialize(options = {})
        @name = options[:name]
        @id = options[:id]
      end
    end
  end
end