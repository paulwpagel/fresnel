require File.expand_path(File.dirname(__FILE__) + "/../../vendor/lighthouse-api/lib/lighthouse")
require "fresnel/ticket_version"

module Fresnel
  class Ticket
    def self.find(*params)
      tickets = Lighthouse::Ticket.find(*params)
      return tickets.collect { |lighthouse_ticket| self.new(lighthouse_ticket) }
    end
    
    def self.attribute_wrapper(attribute)
      define_method(attribute) do
        return @lighthouse_ticket.send(attribute)
      end
    end
    
    attribute_wrapper :id
    attribute_wrapper :state
    attribute_wrapper :title
    attribute_wrapper :milestone_id
    
    def initialize(lighthouse_ticket)
      @lighthouse_ticket = lighthouse_ticket
      @assigned_user_id = lighthouse_ticket.assigned_user_id
      begin
        @lighthouse_versions = lighthouse_ticket.versions
      rescue NoMethodError
        @lighthouse_versions = []
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
    
    def versions
      return @lighthouse_versions.collect { |version| Fresnel::TicketVersion.new(version) }
    end
    
    def description
      return @lighthouse_versions[0].body if @lighthouse_versions[0]
      return ""
    end
    
    def comments
      comment_list = []
      @lighthouse_versions.each_with_index do |version, index|
        comment_list << version.body unless index == 0
      end
      return comment_list
    end
  end
end