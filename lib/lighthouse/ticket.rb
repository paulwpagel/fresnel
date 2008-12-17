require File.expand_path(File.dirname(__FILE__) + "/../../vendor/lighthouse-api/lib/lighthouse")
require "lighthouse/version"

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
    
    def description
      return self.versions[0].body if self.versions[0]
      return ""
    end
    
    def comments
      comment_list = []
      self.versions.each_with_index do |version, index|
        comment_list << version.body unless index == 0
      end
      return comment_list
    end
  end
  
end