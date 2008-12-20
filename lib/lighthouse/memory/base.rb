module Lighthouse
  module Memory
    def self.login_to(account, user, password)
      return true
    end

    def self.find_project(project_name)
      return InMemoryProject.new
    end

    def self.add_ticket(options, project_name)
      @tickets
    end

    def self.milestones(project_name)
      return [InMemoryMilestone.new]
    end

    def self.milestone_title(project_name, milestone_id)
    end

    def self.ticket(id)
      return InMemoryTicket.new
    end
  end
end