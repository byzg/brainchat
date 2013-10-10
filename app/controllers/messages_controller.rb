class MessagesController < ApplicationController

  def create
    @message = Chat.find(params[:chat_id]).messages.new(params[:message])
    redirect_to chat_path(@message.chat) if @message.save
  end

end
