module Fresnel
  class ChangedAttribute
    def initialize(versions, name, current_value)
      @name = name
      @versions = versions
      @current_value = current_value
    end
    
    def name
      return @name.to_s
    end

    def old_value
      return @versions.first.diffable_attributes.send(@name)
    end
    
    def new_value
      @versions[1..@versions.length].each do |version|
        return version.diffable_attributes.send(@name) if version.diffable_attributes.send(@name)
      end
      return @current_value
    end
    
  end
end