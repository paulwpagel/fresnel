require "fresnel/changed_attribute"

module Fresnel
  class ChangedAttributes
    def initialize(versions, ticket)
      @versions = versions
      @ticket = ticket
    end
    
    def list
      attributes = []
      attributes << ChangedAttribute.new(@versions, :title, @ticket.title) if diffable_attributes.title
      attributes << ChangedAttribute.new(@versions, :state, @ticket.state) if diffable_attributes.state
      attributes << ChangedAttribute.new(@versions, :assigned_user_name, @ticket.assigned_user_name) if diffable_attributes.assigned_user_name_has_changed?
      return attributes
    end
    
    private
            
    def diffable_attributes
      return @versions.first.diffable_attributes
    end
  end
end