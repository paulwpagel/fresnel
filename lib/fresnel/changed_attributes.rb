module Fresnel
  class ChangedAttribute
    attr_reader :name, :old_value, :new_value
    def initialize(params={})
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
      add_attribute(attributes, :title) if current_diffable_attributes.title
      add_attribute(attributes, :state) if current_diffable_attributes.state
      return attributes
    end
    
    private
    
    def add_attribute(attributes, name)
      attributes << ChangedAttribute.new(:name => name.to_s, :old_value => old_value(name), :new_value => new_value(name))
    end

    def old_value(attribute)
      current_diffable_attributes.send(attribute)
    end
    
    def new_value(attribute)
      @versions[1..@versions.length].each do |version|
        return version.diffable_attributes.send(attribute) if version.diffable_attributes.send(attribute)
      end
      return @ticket.send(attribute)
    end
    
    private
    
    def current_diffable_attributes
      return @versions.first.diffable_attributes
    end
  end
end