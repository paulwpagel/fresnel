require File.expand_path(File.dirname(__FILE__) + "/../../../vendor/lighthouse-api/lib/lighthouse")
require "lighthouse/lighthouse_api/user"

module Lighthouse
  module LighthouseApi
    class DiffableAttributes
      def initialize(lighthouse_attributes, project_id)
        @lighthouse_attributes = lighthouse_attributes
        @project_id = project_id
      end
    
      def title
        return attempt_attribute(:title)
      end
    
      def state
        return attempt_attribute(:state)
      end
    
      def assigned_user_name
        return assigned_user.name if assigned_user
        return nil
      end
    
      def assigned_user
        return Lighthouse::LighthouseApi::User.find_by_id(assigned_user_id) if assigned_user_id
        return nil
      end
    
      def assigned_user_name_has_changed?
        @lighthouse_attributes.assigned_user rescue return false
        return true
      end
    
      def milestone_title
        milestone.title if milestone
      end
    
      def milestone_title_has_changed?
        @lighthouse_attributes.milestone rescue return false
        return true
      end
    
      def milestone
        begin
          return Lighthouse::Milestone.find(milestone_id, :params => {:project_id => @project_id})
        rescue
          return nil
        end
      end
    
      private
    
      def milestone_id
        @lighthouse_attributes.milestone
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