class ChatsController < InheritedResources::Base

  #respond_to :js, :only => :new

  def index
    @users = User.all
  end

  def show
    @message = Message.new
  end
end
