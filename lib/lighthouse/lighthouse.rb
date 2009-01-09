require 'activeresource'

module Lighthouse
  def self.account=(value)
  end
  def self.authenticate(username, password)
    return true
  end
  class Project
    @@projects = []
    
    def self.destroy_all
      @@projects = []
    end
    
    def self.find(param)
      return @@projects
    end
    
    attr_reader :name, :id
    
    def initialize(options={})
      @name = options[:name]
      @id = nil
    end
    
    def milestones
      return []
    end
    
    def save
      @id = rand 10000
      @@projects << self
    end
  end
  
  class User
  end
  
  class Ticket
    @@tickets = []
    
    def self.destroy_all
      @@tickets = []
    end
    
    def self.find(param_one, param_two)
      if param_one == :all
        project_id = param_two[:params][:project_id]
        return @@tickets.find_all { |ticket| ticket.project_id == project_id }
      else
        return @@tickets.find {|ticket| ticket.id == param_one}
      end
    end
    
    attr_reader :id, :project_id
    attr_accessor :state
    
    def initialize(options={})
      @project_id = options[:project_id]
    end
    
    def save
      @id = rand 10000
      @@tickets << self
    end
  end
  
  class Milestone
  end
  
  class ProjectMembership
    @@project_memberships = []
    
    def self.find(*params)
      project_id = params[1][:params][:project_id]
      return @@project_memberships.find_all {|membership| membership.project_id == project_id}
    end
    
    def self.destroy_all
      @@project_memberships = []
    end
    
    attr_reader :project_id
    
    def initialize(options={})
      @project_id = options[:project_id]
    end
    
    def save
      @@project_memberships << self
    end
  end
end

project = Lighthouse::Project.new(:name => "fresnel")
project.save
