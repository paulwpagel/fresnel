module Lighthouse
  class User
    attr_reader :name, :id
    def initialize(options = {})
      @name = options[:name]
      @id = options[:id]
    end
  end
end