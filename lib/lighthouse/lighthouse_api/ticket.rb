require "lighthouse/lighthouse_api/ticket_version"
require "lighthouse/lighthouse_api/changed_attributes"
require "lighthouse/lighthouse_api/user"
require "lighthouse/lighthouse_api/ticket_accessors"

module Lighthouse
  module LighthouseApi
    class Ticket
      def self.find_tickets(project, query)
        tickets = Lighthouse::Ticket.find(:all, :params => {:project_id => project.id, :q => query})
        return tickets.collect { |lighthouse_ticket| self.new(lighthouse_ticket, project.id) }
      end
      
      include TicketAccessors
      ticket_reader :id
      ticket_accessor :assigned_user_id
      ticket_accessor :state
      ticket_accessor :title
      ticket_accessor :milestone_id
    
      def initialize(lighthouse_ticket, project)
        @lighthouse_ticket = lighthouse_ticket
        @project = project
        begin
          @lighthouse_versions = lighthouse_ticket.versions
        rescue NoMethodError
          @lighthouse_versions = []
        end
      end
      
      def project_id
        return @project.id
      end
      
      def milestone_title
        #TODO use milestone from project
        begin
          milestone = Lighthouse::Milestone.find(milestone_id, :params => {:project_id => project_id})
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
        #TODO use user_name from project
        user = self.assigned_user
        return user.name unless user.nil?
        return ''
      end
    
      def versions
        version_list = []
        @lighthouse_versions.each_with_index do |version, index|
          version_list << Lighthouse::LighthouseApi::TicketVersion.new(version, @project) unless index == 0
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
          
      def new_comment=(comment)
        @lighthouse_ticket.body = comment
      end
    end
  end
end