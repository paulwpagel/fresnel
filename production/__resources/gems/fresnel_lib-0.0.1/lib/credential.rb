require "encrypter"
require "lighthouse/lighthouse_api/base"

class Credential
  class << self
    attr_accessor :account, :login, :password, :project_name
  end
  @@filename = File.expand_path("~/.fresnel_credentials")
  
  def self.load_saved
    if File.exist?(@@filename)
      open_credential
    else
      Credential.set
    end
  end
  
  def self.save_credentials?
    return true if @@save_credentials
    return false
  end
  
  def self.clear_saved
    File.delete(@@filename) if File.exist?(@@filename)
  end
  
  def self.set(options = {})
    Credential.account = options[:account]
    Credential.login = options[:login]
    Credential.password = options[:password]
    Credential.project_name = options[:project_name]
    @@save_credentials = options[:save_credentials]
  end

  def self.save
    clear_saved
    File.open(@@filename, "w+") do |file|
      file.write("#{Encrypter.encrypt(@account)}\n")
      file.write("#{Encrypter.encrypt(@login)}\n")
      file.write("#{Encrypter.encrypt(@password)}\n")
      file.write("#{Encrypter.encrypt(@project_name)}\n")
    end
  end
  
  private
  
  def self.open_credential
    File.open(@@filename, "r") do |file|
      set_credential_from_file(file)
      if attempt_login?
        Credential.save
      else
        Credential.set
      end
    end
  end
  
  def self.set_credential_from_file(file)
    lines = file.read.split("\n")
    if lines.size >= 3
      decrypted_data = lines.collect{ |line| Encrypter.decrypt(line) }
      Credential.set(:account => decrypted_data[0], :login => decrypted_data[1], :password => decrypted_data[2], :project_name => decrypted_data[3], :save_credentials => true)
    end
  end
  
  private
  
  def self.attempt_login?
    return Lighthouse::LighthouseApi.login_to(Credential.account, Credential.login, Credential.password)
  end
end