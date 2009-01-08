require File.expand_path(File.dirname(__FILE__) + "/../../../vendor/lighthouse-api/lib/lighthouse")
require "lighthouse/lighthouse_api/ticket"
require "lighthouse/lighthouse_api/membership"

module Lighthouse
  module LighthouseApi
    class Project
      attr_reader :milestones, :id
    
      def initialize(lighthouse_project)
        @lighthouse_project = lighthouse_project
        @id = lighthouse_project.id
        @milestones = lighthouse_project.milestones
        @users = Membership.all_users_for_project(@id)
      end
      
      def user_names
        @users.collect {|user| user.name }
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
      
      def milestone_title(id)
        return milestone_from_id(id).title if milestone_from_id(id)
        return nil
      end
      
      def milestone_id(title)
        return milestone_from_title(title).id if milestone_from_title(title)
        return nil
      end
      
      def open_states
        return @lighthouse_project.open_states_list.split(",")
      end
      
      def closed_states
        return @lighthouse_project.closed_states_list.split(",")
      end
      
      def all_states
        return open_states + closed_states
      end
                  
      private ######################
      
      def milestone_from_title(title)
        return @milestones.find { |milestone| milestone.title == title }
      end
      
      def milestone_from_id(id)
        return @milestones.find { |milestone| milestone.id == id }
      end
    end
  end
end