require "fresnel/changed_attribute"

module Fresnel
  class ChangedAttributes
    def initialize(versions, ticket)
      @versions = versions
      @ticket = ticket
    end
    
    def list
      attributes = []
      add_attribute(attributes, :title) if diffable_attributes.title
      add_attribute(attributes, :state) if diffable_attributes.state
      add_attribute(attributes, :assigned_user_name) if diffable_attributes.assigned_user_name_has_changed?
      return attributes
    end
    
    private
    
    def add_attribute(attributes, name)
      attributes << ChangedAttribute.new(:name => name.to_s, :old_value => old_value(name), :new_value => new_value(name))
    end

    def old_value(attribute)
      diffable_attributes.send(attribute)
    end
    
    def new_value(attribute)
      @versions[1..@versions.length].each do |version|
        return version.diffable_attributes.send(attribute) if version.diffable_attributes.send(attribute)
      end
      return @ticket.send(attribute)
    end
    
    private
    
    def diffable_attributes
      return @versions.first.diffable_attributes
    end
  end
end