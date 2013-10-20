class ChatsController < InheritedResources::Base
  actions :index, :new
  #respond_to :js, :only => :new

  def create
    #@users = User.where('id IN (?)', params[:chat][:user_ids].select {|i| i=~/^\d+$/})
    #@chat = Chat.new(subject: params[:chat][:subject], users: ["4", "65"])
    #if @chat.save
    #  redirect_to chat_path(@chat)
    #else
    #  redirect_to root_path
    #end
  end

    #@user = User.find(params[:id])
    #@group = Group.new(params[:group])
    #Group.transaction do
    #  if @group.save
    #    if GroupUser.create(params[:group_user].merge{:user => @user, :group => @group})
    #      # success
    #    else
    #      # Could not add user to group
    #    end
    #  else
    #    # Could not create group
    #  end
    #end
  #end

  def show
    @message = Message.new
  end

end


