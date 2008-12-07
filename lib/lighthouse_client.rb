require File.expand_path(File.dirname(__FILE__) + "/../vendor/lighthouse-api/lib/lighthouse")

# puts "tickets.size: #{tickets.size}"
# projects = Lighthouse::Project.find(:all)
# project = projects[0]
# x = Lighthouse::Ticket.find(:all, :params => {:project_id => project.id, :q => "state:open"})
# tickets = Lighthouse::Ticket.find(:all, :params => { :project_id => 21095 })
# x[0].attributes.each_pair do |key, value|
#   puts "#{key},#{value}"
# end

class LighthouseClient  
  
  def authenticate
    Lighthouse.account = "8thlight"
    Lighthouse.token = 'a47514c5dbe30d07302426a4e50709349618c05d'
  end
  
  def find_project(project_name)
    authenticate
    Lighthouse::Project.find(:all).each do |project|
      return project if project.name == project_name
    end
    
    return nil
  end
  
  def add_ticket(options, project_id)
    ticket = Lighthouse::Ticket.new(:project_id => project_id)
    ticket.title = options[:title]
    ticket.save!
    
    return nil
  end

end