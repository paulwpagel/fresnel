module Milestone
  prop_reader :ticket_lister, :milestone_lister
  
  def filter
    ticket_lister.filter_by_milestone(text)
    milestone_lister.activate(id)
  end
end