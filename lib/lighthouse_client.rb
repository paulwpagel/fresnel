require File.expand_path(File.dirname(__FILE__) + "/../vendor/lighthouse-api/lib/lighthouse")

class LighthouseClient  
  
  def login_to(account, user, password)
    Lighthouse.account = account
    Lighthouse.authenticate(user, password)

    begin
      Lighthouse::Project.find(:all)
    rescue ActiveResource::UnauthorizedAccess => e
      return false
    end
    return true
  end
    
  def find_project(project_name)
    Lighthouse::Project.find(:all).each do |project|
      return project if project.name == project_name
    end
    
    return nil
  end
    
  def add_ticket(options, project_id)
    ticket = Lighthouse::Ticket.new(:project_id => project_id)
    ticket.title = options[:title]
    ticket.body = options[:description]
    ticket.body_html = options[:description]
    ticket.save
    
    return nil
  end
  
  def milestones(project_name)
    project = find_project(project_name)
    return project.milestones if project
    return []
  end

  def milestone_title(project_name, milestone_id)
    milestone = milestones(project_name).find {|m| m.id == milestone_id }
    return milestone.title if milestone
    return ""
  end
  
  def ticket(id)
    return Lighthouse::Ticket.find(id, :params => {:project_id => 21095})
  end
end