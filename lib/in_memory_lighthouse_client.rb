class InMemoryProject
end

class InMemoryTicket
end

class InMemoryMilestone
end

class InMemoryLighthouseClient

  def login_to(account, user, password)
    return true
  end

  def find_project(project_name)
    return InMemoryProject.new
  end

  def add_ticket(options, project_id)
  end

  def milestones(project_name)
    return [InMemoryMilestone.new]
  end

  def milestone_title(project_name, milestone_id)
  end

  def ticket(id)
    return InMemoryTicket.new
  end
end
  