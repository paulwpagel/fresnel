require "fresnel/user"

module Fresnel
  class DiffableAttributes
    def initialize(lighthouse_attributes)
      @lighthouse_attributes = lighthouse_attributes
    end
    
    def title
      return attempt_attribute(:title)
    end
    
    def state
      return attempt_attribute(:state)
    end
    
    def assigned_user_name
      user = Fresnel::User.find_by_id(@lighthouse_attributes.assigned_user)
      return user.name if user
      return nil
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