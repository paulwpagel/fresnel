require File.expand_path(File.dirname(__FILE__) + "/../../../vendor/lighthouse-api/lib/lighthouse")
require "lighthouse/lighthouse_api/diffable_attributes"

module Lighthouse
  module LighthouseApi
    class TicketVersion
  
      def initialize(lighthouse_version, project_id)
        @lighthouse_version = lighthouse_version
        @project_id = project_id
      end
  
      def comment
        return @lighthouse_version.body
      end
  
      def timestamp
        return @lighthouse_version.updated_at
      end
  
      def created_by
        return user.name if user
        return ""
      end

      def diffable_attributes
        return Lighthouse::LighthouseApi::DiffableAttributes.new(@lighthouse_version.diffable_attributes, @project_id)
      end
    
      def user
        begin
          return Lighthouse::User.find(@lighthouse_version.user_id)
        rescue ActiveResource::ResourceNotFound => e
          return nil
        end
      end
    end
  end
end