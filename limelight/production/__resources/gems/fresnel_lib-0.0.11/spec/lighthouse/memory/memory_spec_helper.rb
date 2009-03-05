def create_project
  project = Lighthouse::Project.new
  project.save
  return project
end

def create_project_membership(project_id)
  membership = Lighthouse::ProjectMembership.new(:project_id => project_id)
  membership.save
  return membership
end

def create_milestone(options)
  milestone = Lighthouse::Milestone.new(options)
  milestone.save
  return milestone
end

def create_ticket(project_id)
  ticket = Lighthouse::Ticket.new(:project_id => project_id)
  ticket.save
  return ticket
end