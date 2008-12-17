class InMemoryProject
  def open_tickets
    return []
  end
  
  def all_tickets
    return []
  end
end

class InMemoryTicket
end

class InMemoryMilestone
  def title
    return "This title"
  end
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
  