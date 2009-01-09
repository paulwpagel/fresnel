module Lighthouse
  module Memory
    class Membership
      attr_accessor :user_id
      def initialize(options = {})
        @user_id = options[:user_id]
      end
    end
  end
end