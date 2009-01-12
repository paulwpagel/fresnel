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
    
    attr_reader :name, :id, :users
    
    def initialize(options = {})
      @name = options[:name]
      @id = nil
      @users = []
    end
    
    def milestones
      return []
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

  class User
    attr_reader :name, :id
    def initialize(options = {})
      @name = options[:name]
      @id = options[:id]
    end
  end

  class Ticket
    class TicketVersion
      attr_reader :body
      def initialize(options = {})
        @body = options[:body]
      end
    end

    @@tickets = []
    
    def self.destroy_all
      @@tickets = []
    end
    
    def self.find(param_one, param_two)
      query = param_two[:params][:q]
      project_id = param_two[:params][:project_id]
      if param_one == :all && query == "all"
        return @@tickets.find_all { |ticket| ticket.project_id == project_id  }
      elsif param_one == :all && query == "state:open"
        return @@tickets.find_all { |ticket| ticket.project_id == project_id && ticket.state == "open" }
      else
        return @@tickets.find {|ticket| ticket.id == param_one}
      end
    end
    
    attr_reader :id, :project_id, :versions
    attr_accessor :state, :title, :body, :body_html, :assigned_user_id, :milestone_id
    
    def initialize(options={})
      @project_id = options[:project_id]
      @state = "new"
      @versions = []
    end
        
    def save
      unless @id
        @id = rand 10000
        @versions << TicketVersion.new(:body => body)
        @@tickets << self
      end
    end
  end
  
  class Milestone
  end
  
  class ProjectMembership
    @@project_memberships = []
    
    class << self
      def find(*params)
        project_id = params[1][:params][:project_id]
        return @@project_memberships.find_all {|membership| membership.project_id == project_id}
      end
    
      def destroy_all
        @@project_memberships = []
      end
      
      def all_users_for_project(project_id)
        return []
      end
    end
    
    
    attr_reader :project_id
    
    def initialize(options = {})
      @project_id = options[:project_id]
    end
    
    def save
      @@project_memberships << self
    end
    
  end
end

project = Lighthouse::Project.new(:name => "fresnel")
Lighthouse::User.new(:name => "Marion Morison", :id => rand(1000))
project.save
