class MessagesController < InheritedResources::Base

  respond_to :js, :only => :create
  require 'mail'

  def create
    @message = Chat.find(params[:chat_id]).messages.new(params[:message])
    super
  end

  def check_email
    pop = get_pop(session[:current_user_account_password])
    pop_mails = pop.mails
    count_new_letters = pop_mails.count - session[:last_checking_time]
    Rails.logger.info "NEW_MESSAGES = #{count_new_letters}"
    if count_new_letters > 0
      session[:last_checking_time] = pop_mails.count
      letters_raw = pop_mails.last(count_new_letters)
      @letters = []
      request_chat = Chat.find(params[:request_chat_id])
      letters_raw.each do |letter|
        @letters << MessageMailer.receive(letter.pop)
        @letters = @letters.select { |l| request_chat.users.pluck(:email).include?(l[:from]) }
        @letters.each { |l| Message.create(text: l[:text],
                                           incomer_subject: l[:subject],
                                           user_id: current_user.id,
                                           chat_id: request_chat.id) }
      end
      answer = @letters.empty? ? 'none' : render_to_string(partial: 'messages/income_message')
    else
      answer = 'none'
    end
    render json: {messages: answer}
  rescue
    render json: {error: I18n.t('controllers.messages.unknown_error')}
  end

end
