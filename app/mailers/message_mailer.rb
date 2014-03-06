class MessageMailer < ActionMailer::Base
  default from: "from@example.com"

  def receive(email)
    letter = {from: email.from[0], subject: email.subject, charset: email.charset}
    letter[:text] = if email.multipart?
      email.text_part ? decoded_text(email.text_part) : nil
    else
      Rails.logger.info "@"*90
      decoded_text(email)
    end
    letter
  end

  private
  def decoded_text(email_or_part)
    encoding = email_or_part.content_type_parameters['charset']
    text = email_or_part.body.decoded.force_encoding(encoding).encode('UTF-8')
    ActionView::Base.full_sanitizer.sanitize(text)
  end

end
