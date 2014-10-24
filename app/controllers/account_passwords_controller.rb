class AccountPasswordsController < ApplicationController
  skip_before_filter :set_account_password

  def new
    redirect_to root_path if session[:current_user_account_password]
  end

  def create
    session[:account_password_salt] = SecureRandom.hex
    account_password = Encryptor.crypt(ENV['ACCOUNT_PASSWORD_KEY'],
                                       account_password_params[:pass],
                                       session[:account_password_salt])
    conection_attempts = 0
    begin
      if Rails.env.development? && account_password_params[:development] == '1'
        raise Net::POPAuthenticationError unless account_password_params[:pass] == 'qwe321'
        session[:last_mails_count] = 0
      else
        pop = get_pop(account_password)
        session[:last_mails_count] = pop.mails.count
      end
      session[:current_user_account_password] = account_password
      return redirect_to root_path, notice: I18n.t('controllers.account_passwords.notice')
    rescue Net::POPAuthenticationError
      alert =  I18n.t('controllers.account_passwords.authentication_error')
      alert << "  " + I18n.t('controllers.account_passwords.alert_for_gmail_users') if mail_server_and_domain(current_user.email) == 'gmail.com'
      redirect_to new_account_password_path, alert: alert
    rescue Net::OpenTimeout
      conection_attempts += 1
      retry if conection_attempts >= 3
      alert =  I18n.t('controllers.account_passwords.timeout_error')
      redirect_to new_account_password_path, alert: alert
    end
  end

  private
  def account_password_params
    @account_password_params ||= params.require(:account_password).permit(:pass, :development)
  end

end
