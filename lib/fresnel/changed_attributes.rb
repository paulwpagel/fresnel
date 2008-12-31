module Fresnel
  class ChangedAttribute
    attr_accessor :name, :old_value, :new_value
  end

  class ChangedAttributes
    def initialize(versions, ticket)
      @versions = versions
      @ticket = ticket
    end
    
    def list
      attributes = []
      if title_has_changed?
        changed_attribute = ChangedAttribute.new
        changed_attribute.name = "title"
        changed_attribute.old_value = @versions.first.diffable_attributes.title
        changed_attribute.new_value = find_new_title
        attributes << changed_attribute
      end
      return attributes
    end
    
    private
    
    def title_has_changed?
      begin
        @versions.first.diffable_attributes.title
        return true
      rescue
        return false
      end
    end
    
    def find_new_title      
      @versions[1..@versions.length].each do |version|
        begin
          return version.diffable_attributes.title
        rescue
        end
      end
      return @ticket.title
    end
  end
end