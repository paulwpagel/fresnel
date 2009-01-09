require "lighthouse/memory/project"
require "lighthouse/memory/user"
require "lighthouse/memory/membership"

module Lighthouse
  module Memory
    
    def self.create_default_project
      puts "create default project"
      fresnel = Lighthouse::Memory::Project.new(:name => "fresnel", :id => 9)
      fresnel.milestones << Lighthouse::Memory::Milestone.new(:title => "First Milestone")
      fresnel.memberships << Lighthouse::Memory::Membership.new(:user_id => 9)
      return [fresnel]
    end
    
    def self.create_default_users
      user = Lighthouse::Memory::User.new(:name => "Marion", :id => 9)
      return [user]
    end
    
    @@users = create_default_users
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

    def self.ticket(id, project_id)
      current_project = nil
      @@projects.each do |project|
        current_project = project if project.id == project_id
      end
      
      current_project.tickets.each do |ticket|
        return ticket if ticket.id == id
      end if current_project
      raise "There is no ticket with the id=#{id}"
      return nil
    end
    
    def self.users_for_project(project_name)
      users = []
      project = find_project(project_name)
      project.memberships.each do |project_membership|
        users << get_user_by_id(project_membership.user_id)
      end
      return users
    end
    
    def self.get_user_by_id(user_id)
      @@users.each do |user|
        return user if user.id == user_id
      end
      return nil
    end
    
  end
end