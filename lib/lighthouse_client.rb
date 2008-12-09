require File.expand_path(File.dirname(__FILE__) + "/../vendor/lighthouse-api/lib/lighthouse")

# Lighthouse.account = "8thlight"
# Lighthouse.token = 'a47514c5dbe30d07302426a4e50709349618c05d'
# projects = Lighthouse::Project.find(:all)
# project = projects[0]
# x = Lighthouse::Ticket.find(:all, :params => {:project_id => project.id, :q => "state:open"})
# x = Lighthouse::Ticket.find(:all, :params => {:project_id => project.id, :q => "state:open"})

# project.tickets.each do |ticket|
#   puts "ticket.class.name: #{ticket.class.name}"
#   puts "ticket.title: #{ticket.title}"
#   ticket.attributes.each_pair do |key, value|
#     puts "#{key},#{value}"
#   end
# end
# x[0].attributes.each_pair do |key, value|
#   puts "#{key},#{value}"
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

end