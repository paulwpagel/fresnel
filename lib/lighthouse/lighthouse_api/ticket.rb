require "lighthouse/lighthouse_api/ticket_version"
require "lighthouse/lighthouse_api/changed_attributes"
require "lighthouse/lighthouse_api/user"
require "lighthouse/lighthouse_api/ticket_accessors"

module Lighthouse
  module LighthouseApi
    class Ticket
      def self.find_tickets(project, query)
        tickets = Lighthouse::Ticket.find(:all, :params => {:project_id => project.id, :q => query})
        return tickets.collect { |lighthouse_ticket| self.new(lighthouse_ticket, project) }
      end
      
      include TicketAccessors
      ticket_reader :id
      ticket_accessor :assigned_user_id
      ticket_accessor :state
      ticket_accessor :title
      ticket_accessor :milestone_id
      ticket_accessor :created_at
      ticket_accessor :tag
    
      def initialize(lighthouse_ticket, project)
        @lighthouse_ticket = lighthouse_ticket
        @project = project
        begin
          @lighthouse_versions = lighthouse_ticket.versions
        rescue NoMethodError
          @lighthouse_versions = []
        end
      end
      
      def tags
        if @lighthouse_ticket.tag
          return @project.tag_names.find_all { |tag_name| @lighthouse_ticket.tag.match(tag_name) }
        else
          return []
        end
      end
      
      def project_id
        return @project.id
      end
      
      def milestone_title
        @project.milestone_title(milestone_id)
      end
    
      def save
        @lighthouse_ticket.save
      end

      def assigned_user_name
        return @project.user_name(assigned_user_id)
      end
    
      def versions
        return tail_versions.collect { |version| api_version(version) }        
      end      
    
      #TODO - EWM should this method be on TicketVersion instead of Ticket?
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
      
      def age
        return @lighthouse_ticket.updated_at
      end
      
      def formatted_age
        return @lighthouse_ticket.updated_at.strftime("%B %d, %Y @ %I:%M %p")
      end
      
      def matches_criteria?(criteria)
        attributes = [:title, :description, :assigned_user_name, :created_at, :milestone_title, :state, :tag]
        matcher = TicketMatcher.new(self, attributes)
        return matcher.match?(criteria)
      end
      
      private #############################################
      
      def api_version(version)
        return Lighthouse::LighthouseApi::TicketVersion.new(version, @project)
      end
      
      def tail_versions
        return @lighthouse_versions[1..-1] unless @lighthouse_versions.empty?
        return []
      end
    end
    
    class TicketMatcher
      def initialize(ticket, attributes)
        @ticket = ticket
        @attributes = attributes
      end
      
      def match?(criteria)
        @attributes.each do |attribute|
          return true if @ticket.send(attribute) =~ /#{criteria}/
        end
        return false
      end
    end
    
  end
end