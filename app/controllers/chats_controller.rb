class ChatsController < InheritedResources::Base
  actions :index, :new, :create

  def create
    params[:chat][:user_ids].concat(["#{current_user.id}"])
    create! do |success, failure|
      failure.html {return redirect_to :back, alert: resource.errors.full_messages }
    end
    resource.owner = current_user
    resource.save
  end

  def show
    @message = Message.new
  end

  def details
    chat = Chat.find(params[:id])
    messages = chat.messages
    render json: {created_at: chat.created_at.to_s,
                  owner_name: chat.owner.name,
                  messages_count: messages.try(:count).to_i,
                  last_message: messages.try(:last).try(:created_at).to_s,
                  users_names: chat.users.pluck(:name).join(', ')
                  }
  end
  protected
  def begin_of_association_chain
    current_user
  end

end


