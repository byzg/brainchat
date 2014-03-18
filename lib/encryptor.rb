module Encryptor
  LONER_KEY = 'Y\x80\xD0`\x91\x92P\xDD\x94\x1E\xB2} \x81\x92\x8BD\xB2\xF6\x8B\x98\xF4\xB3.Q)r\xE7\x10H\xAA\x91'
  #три последних аргумента либо передавать сразу все либо вообще не передавать
  #хешом не сделано для удобочитаемости
  def self.crypt(key, uncrypted_data, salt = nil, write_salt_session_key = nil, session = nil)
    if salt
      salt  = SecureRandom.random_bytes(64)
      session[write_salt_session_key] = salt
    end
    ActiveSupport::MessageEncryptor.new("#{salt}#{key}#{LONER_KEY}").encrypt_and_sign(uncrypted_data)
  end
  def self.decrypt(key, crypted_data, salt = nil, read_salt_session_key = nil, session = nil)
    salt  = session[read_salt_session_key] if salt
    ActiveSupport::MessageEncryptor.new("#{salt}#{key}#{LONER_KEY}").decrypt_and_verify(crypted_data)
  end
end