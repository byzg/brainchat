class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationControllerHelper
  before_filter :authenticate_user!
  before_filter :set_account_password
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :fill_gon
  private

  def set_account_password
    redirect_to new_account_password_path if user_signed_in? && !(session[:current_user_account_password])
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
  end

  private
  def fill_gon
    gon.current_user ||= {}
    gon.current_user[:logged_in] = !current_user.nil?
  end

end
