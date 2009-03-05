module Lighthouse
  module LighthouseApi
    class ChangedAttribute
      def initialize(version, name)
        @name = name
        @version = version
      end
    
      def name
        return @name.to_s
      end

      def old_value
        return @version.diffable_attributes.send(@name)
      end
    
      def new_value
        return @version.send(@name)
      end
    
    end
  end
end