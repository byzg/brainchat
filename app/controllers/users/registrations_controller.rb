class Users::RegistrationsController < Devise::RegistrationsController

  def create
    user = User.find_by_email(params[:user][:email])
    if user
      unless user.self_created?
        user.update_attributes(user_params)
        if user.invalid?
          resource = build_resource
          resource.errors.messages.merge!(user.errors.messages)
          return render action: :new, alert: user.errors.full_messages
        end
        User.send_confirmation_instructions(email: user.email)
        user.created_by_user_id = user.id; user.save
        return redirect_to new_user_session_path, notice: I18n.t('devise.confirmations.send_instructions')
      end
    end
    super
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end