class AccountPasswordsController < ApplicationController
  skip_before_filter :set_account_password

  def create
    account_password = params[:account_password][:pass]
    pop = get_pop(account_password)
    session[:current_user_account_password] = account_password
    session[:last_checking_time] = pop.mails.count
    return redirect_to root_path, notice: I18n.t('controllers.account_passwords.notice')
  rescue
    alert =  I18n.t('controllers.account_passwords.alert')
    alert << "  " + I18n.t('controllers.account_passwords.alert_for_gmail_users') if mail_server_and_domain(current_user.email) == 'gmail.com'
    redirect_to new_account_password_path, alert: alert
  end


end
