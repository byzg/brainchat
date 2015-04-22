class ChatsController < ApplicationController
  inherit_resources
  actions :index, :new, :create
  respond_to :html, only: [:index, :new, :create]
  respond_to :json, only: [:create]
  before_action :for_chat_need_friend, only: [:new, :create]

  def new
    @friends = current_user.friends.collect{|friend| [friend.name, friend.id]}
    super
  end

  def create
    create! do |success, failure|
      if request.xhr?
        json_answer = if resource.valid?
          {new_chat: render_to_string(partial: 'chats/chat', object: resource)}
        else
          {errors: render_to_string(partial: 'devise/shared/error_messages')}
        end
        return render json: json_answer.merge(success: json_answer[:errors].nil?) 
      end      
      failure.html { return redirect_to new_chat_path, alert: resource.errors.full_messages }
    end
  end

  def show
    return redirect_to root_path, alert: I18n.t('controllers.chats.show.not_found_or_no access') unless current_user.have_chat?(params[:id])
    @available_messages = Message.available_messages(resource, current_user)
    @users = resource.users
    @owner = resource.owner
    @message = Message.new
  end

  def index
    @chats = end_of_association_chain
    .sort_by {|c| c.messages.last.try(:created_at) || DateTime.parse('01.01.1970')}
    .reverse
  end

  protected
  def begin_of_association_chain
    current_user
  end

  def end_of_association_chain
    super.includes(:messages).includes(messages: :user)
  end

  private
  def for_chat_need_friend
    unless current_user.have_friends?
      redirect_to(new_user_friend_assignment_path,
                flash: {info: t('chats.index.create_chat_without_friends', add: t('chats.index..add_friend'))})
    end
  end

  def chat_params
    if !@chat_params && params[:chat] && params[:chat][:user_ids].is_a?(Array)
      params[:chat][:user_ids] = (params[:chat][:user_ids] - [''] + [current_user.id]).uniq
      params[:chat][:owner_id] = current_user.id
    end
    @chat_params ||= params.require(:chat).permit(:subject, :owner_id, user_ids: [])
  end

end


