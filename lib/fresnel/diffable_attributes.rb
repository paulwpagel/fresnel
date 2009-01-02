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
      return assigned_user.name if assigned_user
      return nil
    end
    
    def assigned_user
      return Fresnel::User.find_by_id(assigned_user_id) if assigned_user_id
      return nil
    end
          
    private
    
    def assigned_user_id
      return attempt_attribute(:assigned_user)
    end
    
    def attempt_attribute(name)
      begin
        return @lighthouse_attributes.send(name)
      rescue
        return nil
      end
    end
  end
end