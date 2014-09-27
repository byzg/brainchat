module Encryptor
  LONER_KEY = 'Y\x80\xD0`\x91\x92P\xDD\x94\x1E\xB2} \x81\x92\x8BD\xB2\xF6\x8B\x98\xF4\xB3.Q)r\xE7\x10H\xAA\x91'

  def self.crypt(secure_key, uncrypted_data, salt = nil)
    ActiveSupport::MessageEncryptor.new("#{salt}#{secure_key}#{LONER_KEY}").encrypt_and_sign(uncrypted_data)
  end
  def self.decrypt(secure_key, crypted_data, salt = nil)
    ActiveSupport::MessageEncryptor.new("#{salt}#{secure_key}#{LONER_KEY}").decrypt_and_verify(crypted_data)
  end
end