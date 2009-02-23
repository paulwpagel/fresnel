require "lighthouse/lighthouse_api/project"
require "lighthouse/lighthouse_api/first_project_chooser"

module Lighthouse
  module LighthouseApi
  
    def self.login_to(account, user, password)
      begin
        Lighthouse.account = account
      rescue URI::InvalidURIError
        return false
      end
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
    
    def self.account
      return Lighthouse.account
    end
    
    def self.projects
      return Lighthouse::Project.find(:all) 
    end
    
    def self.find_project(project_name)
      found_project = projects.find { |project| project.name == project_name }      
      return (Lighthouse::LighthouseApi::Project.new(found_project)) if found_project
      return nil
    end
    
    def self.first_project
      return (Lighthouse::LighthouseApi::Project.new(projects.first))
    end
    
    def self.project_names
      return projects.collect {|project| project.name}
    end
    
    def self.get_starting_project_name
      return Lighthouse::LighthouseApi::FirstProjectChooser.new.get_project_name
    end
    
    def self.add_ticket(options, project)
      ticket = Lighthouse::Ticket.new(:project_id => project.id)
      ticket.title = options[:title]
      ticket.body = options[:description]
      ticket.body_html = options[:description]
      ticket.assigned_user_id = options[:assigned_user_id]
      ticket.tag = options[:tag]
      
      ticket.milestone_id = options[:milestone_id]
      ticket.save
      return nil
    end
    
    def self.add_project(project_name)
      project = Lighthouse::Project.new
      project.name = project_name
      project.save
      return nil
    end
    
    def self.ticket(ticket_id, project)
      found_ticket = Lighthouse::Ticket.find(ticket_id, :params => {:project_id => project.id})
      return Lighthouse::LighthouseApi::Ticket.new(found_ticket, project) if found_ticket
      return nil
    end
        
  end
end