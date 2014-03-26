class UsersController < InheritedResources::Base
  actions :new
  def create
    pass = SecureRandom.hex
    user = User.new(params[:user].select {|k,_| %w(name email).include?(k)}
                     .merge({password: pass, password_confirmation: pass}))
    return redirect_to :back, alert: user.errors.full_messages unless user.valid?
    user.skip_confirmation_notification!
    user.save
    user.update_attribute(:created_by_user_id, current_user.id)
    user.creator.friends << user
    redirect_to user_friend_assignments_path, notice: I18n.t('controllers.users.create.notice')    
  end
end
