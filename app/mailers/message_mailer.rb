class MessageMailer < ActionMailer::Base
  require 'encryptor'
  #default from: "koshka@mail.com"

  def send_with_bch_id(message, set_users, current_user)
    headers['X-BCH-ID'] = Encryptor.crypt(ENV['X_BCH_MESSAGE_ID'], message.id)
    mail(to: set_users.map(&:email),
         from: current_user.email,
         subject: message.chat.subject,
         body: message.text
    )
  end

  def receive(email)
    Rails.logger.info '------------   going receive     ----------------------'
    letter = {from: email.from[0], subject: email.subject,
              charset: email.charset, x_bch_id: email['X-BCH-ID'].to_s}
    letter[:text] = if email.multipart?
      email.text_part ? decoded_text(email.text_part) : nil
    else
      decoded_text(email)
    end
    Rails.logger.info '------------   received     ----------------------'
    letter
  end

  private
  def decoded_text(email_or_part)
    encoding = email_or_part.content_type_parameters['charset']
    text = email_or_part.body.decoded.force_encoding(encoding).encode('UTF-8')
    ActionView::Base.full_sanitizer.sanitize(text)
  end

end
