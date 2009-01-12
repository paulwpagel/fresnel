require File.expand_path(File.dirname(__FILE__) + "/../../../vendor/lighthouse-api/lib/lighthouse")
require "lighthouse/lighthouse_api/ticket_version"
require "lighthouse/lighthouse_api/changed_attributes"
require "lighthouse/lighthouse_api/user"
require "lighthouse/lighthouse_api/ticket_accessors"

module Lighthouse
  module LighthouseApi
    class Ticket
      def self.find_tickets(project_id, query)
        tickets = Lighthouse::Ticket.find(:all, :params => {:project_id => project_id, :q => query})
        return tickets.collect { |lighthouse_ticket| self.new(lighthouse_ticket, project_id) }
      end
      
      include TicketAccessors
      ticket_reader :id
      ticket_accessor :assigned_user_id
      ticket_accessor :state
      ticket_accessor :title
      ticket_accessor :milestone_id
      attr_reader :project_id
    
      def initialize(lighthouse_ticket, project)
        @lighthouse_ticket = lighthouse_ticket
        begin
          @lighthouse_versions = lighthouse_ticket.versions
        rescue NoMethodError
          @lighthouse_versions = []
        end
        @project_id = project.id
      end
      
      def milestone_title
        begin
          milestone = Lighthouse::Milestone.find(milestone_id, :params => {:project_id => @project_id})
        rescue
          return nil
        end
        return milestone.title
      end
    
      def save
        @lighthouse_ticket.save
      end
        
      def assigned_user
        return Lighthouse::LighthouseApi::User.find_by_id(assigned_user_id)
      end
  
      def assigned_user_name
        user = self.assigned_user
        return user.name unless user.nil?
        return ''
      end
    
      def versions
        version_list = []
        @lighthouse_versions.each_with_index do |version, index|
          version_list << Lighthouse::LighthouseApi::TicketVersion.new(version, @project_id) unless index == 0
        end
        return version_list
      end
    
      def changed_attributes_for_version(number)
        return Lighthouse::LighthouseApi::ChangedAttributes.new(versions[number..versions.length], self).list
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
      
      def new_comment=(comment)
        @lighthouse_ticket.body = comment
      end
    end
  end
end