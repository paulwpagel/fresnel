require "lighthouse/memory/project"

module Lighthouse
  module Memory
    
    def self.create_default_project
      fresnel = Lighthouse::Memory::Project.new(:name => "fresnel")
      fresnel.milestones << Lighthouse::Memory::Milestone.new(:title => "First Milestone")
      return [fresnel]
    end

    @@projects = create_default_project
    def self.projects
      return @@projects
    end
    
    @@login = true
    def self.login_to(account, user, password)
      return @@login
    end
    
    def self.fail_login
      @@login = false
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
        options[:id] = rand 100000
        ticket = Lighthouse::Memory::Ticket.new(options)
        project.tickets << ticket
      else
        raise "There is no project #{project_name}"
      end
    end
 
    def self.milestones(project_name)
      project = find_project(project_name)
      return project.milestones if project
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