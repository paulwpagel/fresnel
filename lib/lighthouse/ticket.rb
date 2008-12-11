require File.expand_path(File.dirname(__FILE__) + "/../../vendor/lighthouse-api/lib/lighthouse")

module Lighthouse
  
  class Ticket
    def assigned_user
      begin
        return Lighthouse::User.find(self.assigned_user_id)
      rescue
        return nil
      end
    end
    
    def assigned_user_name
      user = self.assigned_user
      return user.name unless user.nil?
      return ''
    end
  end
  
end