require 'digest/sha1'
require 'openssl'

class Encrypter
  def self.key
    return Digest::SHA1.hexdigest("fresnel")
  end

  def self.encrypt(string)
    encrypter = create_cipher
    encrypter.encrypt
    encrypter.key = self.key
    encrypter.update(string)
    return encrypter.final
  end
  
  def self.decrypt(encrypted_data)
    decrypter = create_cipher
    decrypter.decrypt
    decrypter.key = self.key
    decrypter.update(encrypted_data)
    return decrypter.final
  end
  
  private
  
  def self.create_cipher
    return OpenSSL::Cipher::Cipher.new("aes-256-cbc")
  end
end

