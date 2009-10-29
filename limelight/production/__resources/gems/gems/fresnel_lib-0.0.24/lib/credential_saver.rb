require "credential"

class CredentialSaver
  @@filename = File.expand_path("~/.fresnel_credentials")
  
  cattr_accessor :filename
  # attr_reader :credentials
    
  def self.save(credentials)
    File.delete(@@filename) if File.exist?(@@filename)
    File.open(@@filename, "w+") do |file|
      credentials.each do |credential|
        file.write(credential.encrypted) if credential.remember_me?
      end
    end
  end
  
  def self.load_saved
    return load_credentials_from_file if File.exist?(@@filename)
    return []
  end
  
  def self.load_account_names
    return load_valid_credentials.collect { |credential| credential.account }.uniq
  end
  
  def self.clear_all
    File.delete(@@filename) if File.exist?(@@filename)
  end
  
  def self.load_valid_credentials
    return load_saved.find_all { |credential| Lighthouse::LighthouseApi.login_to(credential) }
  end
  
  private #############################################
  
  def self.load_credentials_from_file
    credentials = []
    File.open(@@filename, "r") do |file|
      lines = file.read.split("\n")
      (lines.size/4).times do |credential_number|
        data = lines[credential_number*4..credential_number*4+3].join("\n")
        credentials << Credential.decrypt(data)
      end
    end
    return credentials.compact
  end
end