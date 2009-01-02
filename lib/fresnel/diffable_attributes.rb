module Fresnel
  class DiffableAttributes
    def initialize(lighthouse_attributes)
      @lighthouse_attributes = lighthouse_attributes
    end
    
    def title
      return @lighthouse_attributes.title
    end
  end
end