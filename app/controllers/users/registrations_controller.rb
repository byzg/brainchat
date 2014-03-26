class Users::RegistrationsController < Devise::RegistrationsController

  def create
    user = User.find_by_email(params[:user][:email])
    if user
      unless user.self_created?
        user.update_attributes(name: params[:user][:name], password: params[:user][:password],
                               password_confirmation: params[:user][:password_confirmation])
        if user.invalid?
          resource = build_resource
          resource.errors.messages.merge!(user.errors.messages)
          return render action: :new, alert: user.errors.full_messages
        end
        Devise::Mailer.confirmation_instructions(user).deliver
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

end