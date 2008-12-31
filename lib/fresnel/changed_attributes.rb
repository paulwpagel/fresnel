module Fresnel
  class ChangedAttribute
    attr_reader :name, :old_value, :new_value
    def initialize(params)
      @name = params[:name]
      @old_value = params[:old_value]
      @new_value = params[:new_value]
    end
  end

  class ChangedAttributes
    def initialize(versions, ticket)
      @versions = versions
      @ticket = ticket
    end
    
    def list
      attributes = []
      add_title_attribute(attributes) if title_has_changed?
      return attributes
    end
    
    private
    
    def add_title_attribute(attributes)
      attributes << ChangedAttribute.new(:name => "title", :old_value => old_title, :new_value => new_title)
    end
    
    def title_has_changed?
      begin
        @versions.first.diffable_attributes.title
        return true
      rescue
        return false
      end
    end
    
    def old_title
      @versions.first.diffable_attributes.title
    end
    
    def new_title      
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