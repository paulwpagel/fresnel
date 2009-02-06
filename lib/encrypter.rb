class Encrypter
  def self.encrypt(string)
    value = ""
    string.to_s.each_byte do |byte|
      value << byte.to_s(16)
    end
    return value
  end
  
  def self.decrypt(encrypted_data)
    value = ""
    encrypted_data.scan(/../).each do |tuple|
      value << tuple.hex.chr
    end
    return value
  end
end

