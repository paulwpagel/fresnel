require "lighthouse/lighthouse_api/changed_attribute"

module Lighthouse
  module LighthouseApi
    class ChangedAttributes
      def initialize(version)
        @version = version
      end
    
      def list
        attributes = []
        attributes << ChangedAttribute.new(@version, :title) if diffable_attributes.title
        attributes << ChangedAttribute.new(@version, :state) if diffable_attributes.state
        attributes << ChangedAttribute.new(@version, :assigned_user_name) if diffable_attributes.assigned_user_name_has_changed?
        attributes << ChangedAttribute.new(@version, :milestone_title) if diffable_attributes.milestone_title_has_changed?
        return attributes
      end
    
      private
    
      def diffable_attributes
        return @version.diffable_attributes
      end
    end
  end
end