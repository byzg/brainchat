class UserFriendAssignmentsController < InheritedResources::Base
  actions :new, :create
  def index
    @friend_chats_group = Chat.common_chats_of_user_friends(current_user, 'id, subject').to_a
  end

  def new
    @not_friends = User.not_friends_for(current_user).collect{|friend| [friend.email, friend.id]}
    super
  end

  private
  def user_friend_assignment_params
    @user_friend_assignment_params ||= params.require(:user_friend_assignment).permit(:friend_id).merge(user_id: current_user.id)
  end

end
