module Lighthouse
  class TagResource
    attr_accessor :name
  end
  
  class Project
    @@projects = []
  
    def self.destroy_all
      @@projects = []
    end
  
    def self.find(param)
      return @@projects.find_all { |project| project.account == Lighthouse.account}
    end
  
    attr_reader :name, :id, :users, :account
  
    def initialize(options = {})
      @name = options[:name]
      @account = options[:account]
      @id = nil
      @users = []
    end
    
    def tags
      tag_one = TagResource.new
      tag_one.name = "bug"
      return [tag_one]
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
     
     def tickets
       Lighthouse::Ticket.find(:all, :params => {:project_id => @id, :q => "all"})
     end
  end
end