class MessageMailer < ActionMailer::Base
  default from: "from@example.com"

  def receive(email)
    {:date => email.date, :body => email.body}
  end

end
