require File.expand_path(File.dirname(__FILE__) + "/../../vendor/lighthouse-api/lib/lighthouse")

module Lighthouse
  
  class Ticket
    def assigned_user
      return Lighthouse::User.find(self.assigned_user_id)
    end
    
    def assigned_user_name
      user = self.assigned_user
      return user.name if user
      return ''
    end
  end
  
end