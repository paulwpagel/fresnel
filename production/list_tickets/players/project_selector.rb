module ProjectSelector
  
  def value_changed(event)
    production.lighthouse_client.find_project(text)
  end
end