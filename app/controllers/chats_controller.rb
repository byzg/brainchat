class ChatsController < InheritedResources::Base
  actions :index, :new, :create
  before_action :for_chat_need_friend, only: [:new, :create]

  def create
    params[:chat][:user_ids].concat(["#{current_user.id}"])
    create! do |_, failure|
      failure.html {return redirect_to :back, alert: resource.errors.full_messages }
    end
    resource.owner = current_user
    resource.save
  end

  def show
    return redirect_to root_path, alert: I18n.t('controllers.chats.show.not_found_or_no access') unless current_user.have_chat?(params[:id])
    @message = Message.new
  end

  def details
    chat = Chat.find(params[:id])
    messages = Message.available_messages(chat, current_user)
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

  private
  def for_chat_need_friend
    unless current_user.have_friends?
      redirect_to(new_user_friend_assignment_path,
                flash: {info: t('chats.index.create_chat_without_friends', add: t('chats.index..add_friend'))})
    end
  end

end


