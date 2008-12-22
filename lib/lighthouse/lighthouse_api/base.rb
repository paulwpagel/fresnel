require File.expand_path(File.dirname(__FILE__) + "/../../../vendor/lighthouse-api/lib/lighthouse")

require "lighthouse/project"
require "lighthouse/ticket"

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
    
    def self.find_project(project_name)
      Lighthouse::Project.find(:all).each do |project|
        return project if project.name == project_name
      end
    
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
  
    def self.ticket(id)
      return Lighthouse::Ticket.find(id, :params => {:project_id => 21095})
    end
  end
end