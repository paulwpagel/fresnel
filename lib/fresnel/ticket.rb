require File.expand_path(File.dirname(__FILE__) + "/../../vendor/lighthouse-api/lib/lighthouse")
require "fresnel/ticket_version"

module Fresnel
  class Ticket
    def self.find(*params)
      tickets = Lighthouse::Ticket.find(*params)
      return tickets.collect { |lighthouse_ticket| self.new(lighthouse_ticket) }
    end
    
    def initialize(lighthouse_ticket)
      @assigned_user_id = lighthouse_ticket.assigned_user_id
      begin
        @versions = lighthouse_ticket.versions
      rescue NoMethodError
        ticket = Lighthouse::Ticket.find(lighthouse_ticket.id, :params => {:project_id => 21095})
        @versions = ticket.versions
      end
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
    
    def fresnel_versions
      return @versions.collect { |version| Fresnel::TicketVersion.new(version) }
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