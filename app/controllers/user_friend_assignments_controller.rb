class UserFriendAssignmentsController < ApplicationController
  def index
    @friends = current_user.friends
  end
end
