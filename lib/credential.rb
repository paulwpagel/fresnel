require "encrypter"
require "lighthouse/lighthouse_api/base"

class Credential
  attr_reader :account, :login, :password

  def self.load_saved
    if File.exist?("/fresnel_credentials")
      return opened_credential
    else
      return nil
    end
  end
  
  def initialize(options = {})
    @account ||= options[:account]
    @login ||= options[:login]
    @password ||= options[:password]
  end
  
  def save
    File.open("/fresnel_credentials", "w+") do |file|
      file.write("#{Encrypter.encrypt(@account)}\n")
      file.write("#{Encrypter.encrypt(@login)}\n")
      file.write("#{Encrypter.encrypt(@password)}\n")
    end
  end
  
  private
  
  def self.opened_credential
    File.open("/fresnel_credentials", "r") do |file|
      credential = credential_from_file(file)
      if Lighthouse::LighthouseApi.login_to(credential.account, credential.login, credential.password)
        return credential
      else
        return nil
      end
    end
  end
  
  def self.credential_from_file(file)
    lines = file.read.split("\n")
    decrypted_data = lines.collect{ |line| Encrypter.decrypt(line) }
    return Credential.new(:account => decrypted_data[0], :login => decrypted_data[1], :password => decrypted_data[2])
  end
end