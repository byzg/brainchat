class CustomRuntimeErrorException < RuntimeError
  attr_reader :msg
  def initialize(msg_key, msg_opts = {})
    @msg = I18n.t("exceptions.#{self.class.name.sub('Exception', '').underscore}.#{msg_key.to_s}", msg_opts)
  end
end
class EncryptorException < CustomRuntimeErrorException; end