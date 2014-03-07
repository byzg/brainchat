class MessageMailer < ActionMailer::Base
  default from: "from@example.com"

  def receive(email)
    Rails.logger.info '------------   going receive     ----------------------'
    letter = {from: email.from[0], subject: email.subject, charset: email.charset}
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
