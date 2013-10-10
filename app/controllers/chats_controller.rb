class ChatsController < InheritedResources::Base
  def show
    @message = Message.new
  end
end
