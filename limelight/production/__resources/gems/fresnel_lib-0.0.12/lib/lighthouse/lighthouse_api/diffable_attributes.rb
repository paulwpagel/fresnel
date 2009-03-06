require "lighthouse/lighthouse_api/user"

module Lighthouse
  module LighthouseApi
    class DiffableAttributes
      def initialize(lighthouse_attributes, project)
        @lighthouse_attributes = lighthouse_attributes
        @project = project
      end
    
      def title
        return attempt_attribute(:title)
      end
    
      def state
        return attempt_attribute(:state)
      end
    
      def assigned_user_name
        return @project.user_name(assigned_user_id)
      end

      def assigned_user_name_has_changed?
        @lighthouse_attributes.assigned_user rescue return false
        return true
      end
    
      def milestone_title
        return @project.milestone_title(milestone_id)
      end
    
      def milestone_title_has_changed?
        @lighthouse_attributes.milestone rescue return false
        return true
      end
    
      private
    
      def milestone_id
        return attempt_attribute(:milestone)
      end
    
      def assigned_user_id
        return attempt_attribute(:assigned_user)
      end
    
      def attempt_attribute(name)
        begin
          return @lighthouse_attributes.send(name)
        rescue
          return nil
        end
      end
    end
  end
end