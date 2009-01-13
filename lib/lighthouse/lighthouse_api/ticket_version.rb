require "lighthouse/lighthouse_api/diffable_attributes"

module Lighthouse
  module LighthouseApi
    class TicketVersion
  
      def initialize(lighthouse_version, project)
        @lighthouse_version = lighthouse_version
        @project_id = project.id
        @project = project
      end
  
      def comment
        return @lighthouse_version.body
      end
  
      def timestamp
        return @lighthouse_version.updated_at.strftime("%B %d, %Y @ %I:%M %p")
      end
  
      def created_by
        return @project.user_name(@lighthouse_version.user_id)
      end

      def diffable_attributes
        return Lighthouse::LighthouseApi::DiffableAttributes.new(@lighthouse_version.diffable_attributes, @project)
      end

    end
  end
end