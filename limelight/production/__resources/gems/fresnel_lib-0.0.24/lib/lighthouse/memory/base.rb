module Lighthouse
  
  def self.account=(value)
    @@account = value
  end
  
  def self.account
    return @@account
  end
  
  def self.authenticate(username, password)
    return true
  end
end
