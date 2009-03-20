require "lighthouse/lighthouse_api/project"

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
    
    def self.project_names
      return projects.collect {|project| project.name}
    end
    
    def self.add_ticket(options, project)
      ticket = Lighthouse::Ticket.new(:project_id => project.id)
      ticket.title = options[:title]
      ticket.body = options[:description]
      ticket.body_html = options[:description]
      ticket.assigned_user_id = project.user_id(options[:assigned_user])
      ticket.tag = options[:tags]
      
      ticket.milestone_id = project.milestone_id(options[:milestone])
      ticket.save
      return nil
    end
    
    def self.add_project(options)
      project = Lighthouse::Project.new
      project.name = options[:name]
      project.public = options[:public]
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