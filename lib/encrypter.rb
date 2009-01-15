require 'digest/sha1'
require 'openssl'

class Encrypter
  def self.key
    return Digest::SHA1.hexdigest("fresnel")
  end
  
  def self.encrypt(string)
    encrypter = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
    encrypter.encrypt
    encrypter.key = self.key
    encrypter.update(string)
    return encrypter.final
  end
  
  def self.decrypt(encrypted_data)
  end
end

