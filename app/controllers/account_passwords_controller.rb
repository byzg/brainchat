class AccountPasswordsController < ApplicationController
  skip_before_filter :set_account_password

  def create
    account_password = params[:account_password][:pass]
    pop = Net::POP3.new("pop.#{mail_server_and_domain(current_user.email)}")
    pop.start(current_user.email, account_password)
    session[:current_user_account_password] = account_password
    session[:last_checking_time] = pop.mails.count
    return redirect_to root_path, notice: I18n.t('controllers.account_passwords.notice')
  rescue
    redirect_to new_account_password_path, alert: I18n.t('controllers.account_passwords.alert')
  end


end
