require File.expand_path(File.dirname(__FILE__) + "/../../vendor/lighthouse-api/lib/lighthouse")

module Lighthouse
  class Ticket
    class Version
      def comment
        return self.body
      end
  
      def created_by
        begin
          user = Lighthouse::User.find(self.user_id)
        rescue ActiveResource::ResourceNotFound => e
        end
        return user.name if user
        return ""
      end
    end
  end
end