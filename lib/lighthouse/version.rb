require File.expand_path(File.dirname(__FILE__) + "/../../vendor/lighthouse-api/lib/lighthouse")

module Lighthouse
  class Ticket
    class Version
      def comment
        return self.body
      end
  
      def created_by
        return user.name if user
        return ""
      end
      
      def user
        begin
          return Lighthouse::User.find(self.user_id)
        rescue ActiveResource::ResourceNotFound => e
          return nil
        end
      end
    end
  end
end