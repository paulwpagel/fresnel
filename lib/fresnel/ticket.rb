require File.expand_path(File.dirname(__FILE__) + "/../../vendor/lighthouse-api/lib/lighthouse")
require "fresnel/ticket_version"

module Fresnel
  class Ticket
    def self.find(*params)
      tickets = Lighthouse::Ticket.find(*params)
      return tickets.collect { |lighthouse_ticket| self.new(lighthouse_ticket) }
    end
    
    def self.ticket_accessor(method)
      define_method(method) do
        return @lighthouse_ticket.send(method)
      end
      writer = "#{method}="
      define_method(writer) do |value|
        @lighthouse_ticket.send(writer, value)
      end
    end
    
    ticket_accessor :id
    ticket_accessor :state
    ticket_accessor :title
    ticket_accessor :milestone_id
    
    def initialize(lighthouse_ticket)
      @lighthouse_ticket = lighthouse_ticket
      @assigned_user_id = lighthouse_ticket.assigned_user_id
      begin
        @lighthouse_versions = lighthouse_ticket.versions
      rescue NoMethodError
        @lighthouse_versions = []
      end
    end
    
    def save
      @lighthouse_ticket.save
    end
    
    def milestone_id=(id)
      @lighthouse_ticket.milestone_id = id
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
      version_list = []
      @lighthouse_versions.each_with_index do |version, index|
        version_list << Fresnel::TicketVersion.new(version) unless index == 0
      end
      return version_list
    end
    
    def changed_attributes_for_version(number)
      return []
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