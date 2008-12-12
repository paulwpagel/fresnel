require File.expand_path(File.dirname(__FILE__) + "/../vendor/lighthouse-api/lib/lighthouse")

# Lighthouse.account = "8thlight"
# Lighthouse.token = 'a47514c5dbe30d07302426a4e50709349618c05d'

# ticket = Lighthouse::Ticket.new(:project_id => "21095")
# ticket.title = "TEST ticket"
# ticket.save

# ticket = Lighthouse::Ticket.find(15, :params => { :project_id => 21095 })
# tickets.each do |ticket|
#   puts "ticket.title: #{ticket.title}"
#   puts ticket.body
# end


# puts "ticket.id: #{ticket.id}"
# puts "ticket.title: #{ticket.title}"
# puts ticket.versions
# ticket.versions.each do |version|
#   puts version.body
# end


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
  
end