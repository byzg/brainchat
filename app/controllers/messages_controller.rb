class MessagesController < InheritedResources::Base

  respond_to :js, only: :create
  require 'mail'

  def create
    @message = Chat.find(params[:chat_id]).messages.new(params[:message])
    super
  end

  def check_email
    #Thread..new do end
    render json: {messages: receive}
  rescue
    render json: {error: I18n.t('controllers.messages.unknown_error')}
  end

  private
  def receive
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
        l = MessageMailer.receive(letter.pop)
        sender = request_chat.users.where(email: l[:from]).try(:first)
        if sender && (current_user.is_owner?(request_chat) || sender.email == request_chat.owner.email)
          @letters << l
          Message.create(text: l[:text],
                         incomer_subject: l[:subject],
                         user_id: sender.id,
                         chat_id: request_chat.id)
        end
      end
      answer = @letters.empty? ? 'none' : render_to_string(partial: 'messages/income_message')
    else
      answer = 'none'
    end
    answer
  end

  #def receive
  #  Rails.logger.info "Вошли в ресив"; i = 0
  #  while true
  #    i += 1
  #    Rails.logger.info "Итерация цикла #{i}"
  #    pop = get_pop(session[:current_user_account_password])
  #    pop_mails = pop.mails
  #    count_new_letters = pop_mails.count - session[:last_checking_time]
  #    Rails.logger.info "NEW_MESSAGES = #{count_new_letters}"
  #    if count_new_letters > 0
  #      session[:last_checking_time] = pop_mails.count
  #      letters_raw = pop_mails.last(count_new_letters)
  #      @letters = []
  #      request_chat = Chat.find(params[:request_chat_id])
  #      letters_raw.each do |letter|
  #        l = MessageMailer.receive(letter.pop)
  #        sender = request_chat.users.where(email: l[:from]).try(:first)
  #        if sender && (current_user.is_owner?(request_chat) || sender.email == request_chat.owner.email)
  #          @letters << l
  #          Message.create(text: l[:text],
  #                         incomer_subject: l[:subject],
  #                         user_id: sender.id,
  #                         chat_id: request_chat.id)
  #        end
  #      end
  #      break
  #      return (@letters.empty? ? 'none' : render_to_string(partial: 'messages/income_message'))
  #    end
  #    Rails.logger.info "Новых сообщений нет. Спим 10 секунд"
  #    sleep 10
  #  end
  #end

end
