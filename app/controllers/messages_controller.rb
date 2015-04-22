class MessagesController < InheritedResources::Base
  respond_to :js, only: :create
  before_filter lambda { params[:message].merge!({chat_id: params[:chat_id],
                                                  user_id: current_user.id}) }, only: :create
  after_filter :mass_sending, only: :create

  def check_email
    render json: {messages: receive}
  rescue Net::POPAuthenticationError => e
    handle_exception(e, 'authentication_error')
  rescue Exception => e
    handle_exception(e, 'unknown_error')
  end

  private

  def message_params
    Rails.logger.info params
    params.require(:message).permit(:text, :incomer_subject, :chat_id, :user_id)    
  end

  def receive
    pop = get_pop(session[:current_user_account_password])
    pop_mails = pop.mails
    count_new_letters = pop_mails.count - session[:last_mails_count]
    Rails.logger.info "INCOME_MESSAGES_COUNT = #{count_new_letters} from #{current_user.email}"
    if count_new_letters > 0
      session[:last_mails_count] = pop_mails.count
      letters_raw = pop_mails.last(count_new_letters)
      @letters = []
      request_chat = Chat.find(params[:request_chat_id])
      letters_raw.each do |letter|
        l = MessageMailer.receive(letter.pop)
        sender = request_chat.users.where(email: l[:from]).try(:first)
        if sender && (current_user.is_owner?(request_chat) || sender.email == request_chat.owner.email)
          logg l
          if l[:x_bch_id]
            begin
              message_id = Encryptor.decrypt(ENV['X_BCH_MESSAGE_ID'], l[:x_bch_id])
            rescue ActiveSupport::MessageVerifier::InvalidSignature
              logg "Зафиксирована попытка имитировать отправку из Брейнчата!!"
            ensure
              message_exist = Message.find_by_id(message_id)
            end
          end
          message = Message.new(text: l[:text],
                                incomer_subject: l[:subject],
                                user_id: sender.id,
                                chat_id: request_chat.id)
          @letters << message
          message.save unless message_exist
        end
      end
      answer = @letters.empty? ? 'none' : render_to_string(partial: 'messages/message', collection: @letters)
    else
      session[:last_mails_count] = pop_mails.count if count_new_letters < 0
      answer = 'none'
    end
    pop.finish
    answer
  end

  def mass_sending
    if resource.valid?
      set = (if current_user.is_owner?(resource.chat) then
        resource.chat.users.select {|user| user.id != current_user.id}
      else
        [resource.chat.owner]
      end).select { |user| current_user.can_send_messages_to?(user) }
      MessageMailer.send_with_bch_id(resource, set, current_user).deliver unless set.empty?
    end
  end

  def handle_exception(e, locale_key)
    exception_log(e)
    locale_error = I18n.t("controllers.messages.#{locale_key}")
    render json: {error: "#{locale_error} #{I18n.t('controllers.messages.autoreload')}"}
  end

end