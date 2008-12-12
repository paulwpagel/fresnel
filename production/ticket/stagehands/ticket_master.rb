# require "lighthouse/project"
class LighthouseTicket
  attr_reader :id, :title, :state
  def initialize(id, title, state)
    @id = id
    @title = title
    @state = state
  end
end
class TicketMaster
  def initialize(scene)
    puts 'initialized ticket_master'
    puts "scene: #{scene.inspect}"
    @scene = scene
  end
  def show_tickets(type)
    tickets = [LighthouseTicket.new(123, "Hello World", type)]
    dude = @scene.ticket_lister
    puts dude.inspect
    dude.show_these_tickets(tickets)
  end
end