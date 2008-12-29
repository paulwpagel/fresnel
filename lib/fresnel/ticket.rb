require File.expand_path(File.dirname(__FILE__) + "/../../vendor/lighthouse-api/lib/lighthouse")

module Fresnel
  class Ticket
    def initialize(lighthouse_ticket)
      @assigned_user_id = lighthouse_ticket.assigned_user_id
      @versions = lighthouse_ticket.versions
    end
    
    def assigned_user
      begin
        return Lighthouse::User.find(@assigned_user_id)
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
      return @versions[0].body if @versions[0]
      return ""
    end
    
    def comments
      comment_list = []
      @versions.each_with_index do |version, index|
        comment_list << version.body unless index == 0
      end
      return comment_list
    end
    
  end
end