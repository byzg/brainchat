class UsersController < InheritedResources::Base
  actions :new
  def create
    pass = SecureRandom.hex
    user = User.new(user_params.merge({password: pass, password_confirmation: pass}))
    return redirect_to new_user_path, alert: user.errors.full_messages unless user.valid?
    user.skip_confirmation_notification!
    user.save
    user.update_attribute(:created_by_user_id, current_user.id)
    user.creator.friends << user
    redirect_to user_friend_assignments_path, notice: I18n.t('controllers.users.create.notice')    
  rescue
    Rails.logger.info $!
    raise $!
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
