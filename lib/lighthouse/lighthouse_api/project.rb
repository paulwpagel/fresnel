require File.expand_path(File.dirname(__FILE__) + "/../../../vendor/lighthouse-api/lib/lighthouse")
require "lighthouse/lighthouse_api/ticket"

module Lighthouse
  module LighthouseApi
    class Project
      attr_reader :milestones, :id
    
      def initialize(lighthouse_project)
        @id = lighthouse_project.id
        @milestones = lighthouse_project.milestones
      end
    
      def open_tickets
        return Lighthouse::LighthouseApi::Ticket.find_tickets(@id, "state:open")
      end
    
      def all_tickets
        return Lighthouse::LighthouseApi::Ticket.find_tickets(@id, "all")
      end
    
      def milestone_titles
        return @milestones.collect { |milestone| milestone.title }
      end
    end
  end
end