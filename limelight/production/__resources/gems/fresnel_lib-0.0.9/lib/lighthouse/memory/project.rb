module Lighthouse
  class Project
    @@projects = []
  
    def self.destroy_all
      @@projects = []
    end
  
    def self.find(param)
      return @@projects
    end
  
    attr_reader :name, :id, :users, :tags
  
    def initialize(options = {})
      @name = options[:name]
      @id = nil
      @users = []
      @tags = []
    end
  
    def milestones
      return Lighthouse::Milestone.find(:all, :params => {:project_id => @id})
    end
  
    def save
      @id = rand 10000
      @@projects << self
    end

     def open_states_list
       return "new,open"
     end

     def closed_states_list
       return "resolved,hold,invalid"
     end
  end
end