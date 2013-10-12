class ChatsController < InheritedResources::Base

  def index
    @users = User.all
  end

  def show
    @message = Message.new
  end
end
