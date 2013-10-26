class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :set_account_password, if: :account_password_not_given?
  private

  def set_account_password
    redirect_to new_account_password_path
  end

  def account_password_not_given?
    user_signed_in? && !(session[:current_user_account_password])
  end

  def mail_server_and_domain(email)
    email[((email =~ /@/)+1)..-1]
  end

end
