require File.expand_path(File.dirname(__FILE__) + "/../vendor/lighthouse-api/lib/lighthouse")


Lighthouse.account = "8thlight"
# Lighthouse.authenticate('paul@8thlight.com', 'marxism')
Lighthouse.token = 'a47514c5dbe30d07302426a4e50709349618c05d'
puts Lighthouse::Project.find(:all)


class LighthouseClient  
  def find_projects
  end
end