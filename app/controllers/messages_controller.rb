class MessagesController < InheritedResources::Base

  respond_to :js, :only => :create

  def create
    @message = Chat.find(params[:chat_id]).messages.new(params[:message])
    super
  end

end
