require File.expand_path(File.dirname(__FILE__) + "/../../../vendor/lighthouse-api/lib/lighthouse")
require "lighthouse/lighthouse_api/project"

module Lighthouse
  module LighthouseApi
  
    def self.login_to(account, user, password)
      Lighthouse.account = account
      Lighthouse.authenticate(user, password)

      begin
        Lighthouse::Project.find(:all)
      rescue ActiveResource::UnauthorizedAccess => e
        return false
      rescue ActiveResource::ResourceNotFound
        return false
      end
      return true
    end
    
    def self.projects
      return Lighthouse::Project.find(:all) 
    end
    
    def self.find_project(project_name)
      found_project = projects.find { |project| project.name == project_name }      
      return (Lighthouse::LighthouseApi::Project.new(found_project)) if found_project
      return nil
    end
    
    def self.add_ticket(options, project_name)
      project = find_project(project_name)
      ticket = Lighthouse::Ticket.new(:project_id => project.id)
      ticket.title = options[:title]
      ticket.body = options[:description]
      ticket.body_html = options[:description]
      ticket.save
      return nil
    end
  
    def self.milestones(project_name)
      project = find_project(project_name)
      return project.milestones if project
      return []
    end

    def self.milestone_title(project_name, milestone_id)
      milestone = milestones(project_name).find {|m| m.id == milestone_id }
      return milestone.title if milestone
      return ""
    end
  
    def self.ticket(ticket_id, project)
      found_ticket = Lighthouse::Ticket.find(ticket_id, :params => {:project_id => project.id})
      return Lighthouse::LighthouseApi::Ticket.new(found_ticket, project.id) if found_ticket
      return nil
    end
    
    def self.users_for_project(project_name)
      users = []
      project = find_project(project_name)
      project.users.each do |project_membership|
        users << Lighthouse::User.find(project_membership.id)
      end
      return users
    end
    
  end
end