require File.expand_path(File.dirname(__FILE__) + "/../../../vendor/lighthouse-api/lib/lighthouse")

module Lighthouse
  module LighthouseApi
    class User
      def self.find_by_id(id)
        begin
          Lighthouse::User.find(id)
        rescue
          return nil
        end
      end
      
      def self.user_name_for_id(id)
        cached_user = find_by_id(id)
        return cached_user.name if cached_user
      end
    end
  end
end