class MessagesController < InheritedResources::Base

  respond_to :js, :only => :create
  require 'mail'

  def create
    @message = Chat.find(params[:chat_id]).messages.new(params[:message])
    super
  end

  def check_email
    account_password = session[:current_user_account_password]
    pop = get_pop(account_password)
    count_new_letters = pop.mails.count - session[:last_checking_time]
    Rails.logger.info "NEW_MESSAGES = #{count_new_letters}"
    if count_new_letters > 0
      session[:last_checking_time] = pop.mails.count
      letters_raw = pop.mails.last(count_new_letters)
      @letters = []
      letters_raw.each do |letter|
        @letters << MessageMailer.receive(letter.pop)
      end
      render json: {messages: (render_to_string :partial => 'messages/income_message')}
    else
      render json: {messages: 'none'}
    end
    #render json: {error: "у вас #{count_new_letters} новых писем"}
    #render json: {message: pop.mails.count, notify: (render_to_string :partial => 'messages/notify')}
  rescue
    render :json => {error: I18n.t('controllers.messages.unknown_error')}
  end

end
