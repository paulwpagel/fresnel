module Fresnel
  class DiffableAttributes
    def initialize(lighthouse_attributes)
      @lighthouse_attributes = lighthouse_attributes
    end
    
    def title
      return attempt_attribute(:title)
    end
    
    def title_has_changed?
      return true if title
      return false
    end
    
    def state
      return attempt_attribute(:state)
    end
    
    def state_has_changed?
      return true if state
      return false
    end
    
    private
    
    def attempt_attribute(name)
      begin
        return @lighthouse_attributes.send(name)
      rescue
        return nil
      end
    end
  end
end