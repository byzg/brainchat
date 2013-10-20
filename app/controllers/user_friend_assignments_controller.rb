class UserFriendAssignmentsController < ApplicationController

  def index
    @friends = current_user.friends
  end

  def new
    @friend = UserFriendAssignment.new
  end

end
