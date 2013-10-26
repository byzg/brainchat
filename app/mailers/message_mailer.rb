class MessageMailer < ActionMailer::Base
  default from: "from@example.com"

  def receive(email)
    {:date => email.date, :body => TMail::Mail.parse(email.body)}
  end

end
