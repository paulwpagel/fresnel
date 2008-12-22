require "lighthouse/memory/project"

module Lighthouse
  module Memory
    
    def self.create_default_project
      return [Lighthouse::Memory::Project.new(:name => "fresnel")]
    end

    @@projects = create_default_project
    
    def self.projects
      return @@projects
    end
    
    def self.login_to(account, user, password)
      return true
    end

    def self.find_project(project_name)
      @@projects.each do |project|
        return project if project.name == project_name
      end
      
      return nil
    end

    def self.add_ticket(options, project_name)
      project = find_project(project_name)
      if project
        ticket = Lighthouse::Memory::Ticket.new(options)
        project.tickets << ticket
      end
    end

    def self.milestones(project_name)
      return []
    end

    def self.milestone_title(project_name, milestone_id)
      return nil
    end

    def self.ticket(id)
      return nil
    end
  end
end