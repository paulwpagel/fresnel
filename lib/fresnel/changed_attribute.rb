module Fresnel
  class ChangedAttribute
    attr_reader :name, :old_value, :new_value
    def initialize(options={})
      @name = options[:name]
      @old_value = options[:old_value]
      @new_value = options[:new_value]
    end
  end
end