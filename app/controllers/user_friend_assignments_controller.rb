class UserFriendAssignmentsController < InheritedResources::Base
  actions :new, :create
  def index
    @friends = current_user.friends
  end

  def new
    @not_friends = User.not_friends_for(current_user).collect{|friend| [friend.email, friend.id]}
    super
  end

  def create
    create! do |_, fail|
      fail.html { redirect_to new_user_friend_assignment_path, alert: resource.errors.full_messages }
    end
  end

  private
  def user_friend_assignment_params
    @user_friend_assignment_params ||= params.require(:user_friend_assignment).permit(:friend_id).merge(user_id: current_user.id)
  end

end
