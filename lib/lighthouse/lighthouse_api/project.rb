require "lighthouse/lighthouse_api/ticket"
require "lighthouse/lighthouse_api/project_membership"

module Lighthouse
  module LighthouseApi
    class Project
      attr_reader :milestones, :id, :users
          
      def initialize(lighthouse_project)
        @lighthouse_project = lighthouse_project
        @id = lighthouse_project.id
        @milestones = lighthouse_project.milestones
        @users = ProjectMembership.all_users_for_project(@id)
      end
      
      def user_names
        @users.collect {|user| user.name }
      end
      
      def user_id(user_name)
        return user_from_name(user_name).id if user_from_name(user_name)
        return nil
      end
      
      def user_name(user_id)
        return user_from_id(user_id).name if user_from_id(user_id)
        return nil
      end
      
      def open_tickets
        return Lighthouse::LighthouseApi::Ticket.find_tickets(self, "state:open")
      end
    
      def all_tickets
        return Lighthouse::LighthouseApi::Ticket.find_tickets(self, "all")
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
      
      def user_from_name(user_name)
        return @users.find { |user| user.name == user_name }
      end
      
      def user_from_id(user_id)
        return @users.find { |user| user.id == user_id }
      end
      
      def milestone_from_title(title)
        return @milestones.find { |milestone| milestone.title == title }
      end
      
      def milestone_from_id(id)
        return @milestones.find { |milestone| milestone.id == id }
      end
    end
  end
end