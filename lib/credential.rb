require "encrypter"

class Credential
  attr_reader :account, :login, :password, :logged_in

  def initialize(options = {})
    @account ||= options[:account]
    @login ||= options[:login]
    @password ||= options[:password]
    @logged_in ||= options[:logged_in]
  end
  
  def logged_in?
    return @logged_in
  end
  
  def save
    File.open("/fresnel_credentials", "w+") do |file|
      file.write(Encrypter.encrypt(@password))
    end
  end
end