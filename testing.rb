require File.expand_path(File.dirname(__FILE__) + "/vendor/lighthouse-api/lib/lighthouse")

Lighthouse.account = "8thlight"
Lighthouse.token = '54628d49f8bf67370b2ad2699b2c1076f5bf323c'
all_tickets = Lighthouse::Ticket.find(:all, :params => {:project_id => 22835, :q => "all"})

project = Lighthouse::Project.find(22835)
# puts "project.name: #{project.name}"
# puts "project.tickets: #{project.tickets}"
t = Lighthouse::Ticket.find(15, :params => {:project_id => 22835})
m = (t.methods - Object.new.methods).sort.join("\n")
puts m
puts "t.title: #{t.title}"
t.destroy
# puts "t.tag: #{t.tag.split(' ')}"
# puts "t.title: #{t.title}"
# puts "project.tags: #{project.tags.size}"
# project.tags.each do |tag|
#   puts "tag: #{tag.name}"
# end
# t.tag = "something different"
# t.save
# m = t.versions[0].methods - Object.methods
# # puts "m.sort.join(\"\n\"): #{m.sort.join("\n")}"
# 
# t.versions.each_with_index do |v, index|
#   puts "#{index}: #{v.title}"
# end
# open_tickets = Lighthouse::Ticket.find(:all, :params => {:project_id => project.id, :q => "state:open"})
# puts "tickets.size: #{tickets.size}"
# puts "all_tickets.size: #{all_tickets.size}"
# puts "open_tickets.size: #{open_tickets.size}"
