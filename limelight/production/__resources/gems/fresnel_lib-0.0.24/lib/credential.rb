require "encrypter"
require "lighthouse/lighthouse_api/base"

class Credential
  
  def self.decrypt(encrypted_data)
    lines = encrypted_data.split("\n")
    if lines.size >= 4
      decrypted_data = lines.collect{ |line| Encrypter.decrypt(line) }
      return Credential.new(decrypted_data[0], decrypted_data[1], decrypted_data[2], decrypted_data[3], true)
    else
      return nil
    end
  end
  
  attr_reader :account, :login, :password
  attr_accessor :project_name
  
  def initialize(account, login, password, project_name, remember_me)
    @account = account
    @login = login
    @password = password
    @project_name = project_name
    @remember_me = remember_me
  end
  
  def remember_me?
    return @remember_me
  end
  
  def encrypted
    data = ""
    data << "#{Encrypter.encrypt(@account)}\n"
    data << "#{Encrypter.encrypt(@login)}\n"
    data << "#{Encrypter.encrypt(@password)}\n"
    data << "#{Encrypter.encrypt(@project_name)}\n"
    return data
  end
end