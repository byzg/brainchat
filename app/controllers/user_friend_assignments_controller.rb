class UserFriendAssignmentsController < InheritedResources::Base
  def index
    @friend_chats_group = Chat.common_chats_of_user_friends(current_user, 'id, subject').to_a
  end

  def new
    @not_friends = User.not_friends_for(current_user).collect{|friend| [friend.email, friend.id]}
    super
  end

end
