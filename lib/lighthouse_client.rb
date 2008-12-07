require File.expand_path(File.dirname(__FILE__) + "/../vendor/lighthouse-api/lib/lighthouse")

Lighthouse.account = "8thlight"
Lighthouse.token = 'a47514c5dbe30d07302426a4e50709349618c05d'

# puts "tickets.size: #{tickets.size}"
projects = Lighthouse::Project.find(:all)
project = projects[1]
# x = Lighthouse::Ticket.find(:all, :params => {:project_id => project.id, :q => "state:open"})
# puts x.size
puts "project.id: #{project.id}"
# tickets = Lighthouse::Ticket.find(:all, :params => { :project_id => 21095 })
# puts "project.tickets.size: #{project.tickets.size}"
# x[0].attributes.each_pair do |key, value|
#   puts "#{key},#{value}"
# end

# project.tickets.each do |ticket|
#   puts ticket.title
# end
# 
# puts "********************"
# puts project.tickets[0].methods.sort
# puts project.name
# puts project.methods.sort
# puts project.to_s

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