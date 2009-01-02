require File.expand_path(File.dirname(__FILE__) + "/../../vendor/lighthouse-api/lib/lighthouse")
require "fresnel/diffable_attributes"

module Fresnel
  class TicketVersion
  
    def initialize(lighthouse_version)
      @lighthouse_version = lighthouse_version
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
      return Fresnel::DiffableAttributes.new(@lighthouse_version.diffable_attributes)
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