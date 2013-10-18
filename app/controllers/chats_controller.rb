class ChatsController < InheritedResources::Base

  #respond_to :js, :only => :new
  #before_filter :get_interlocutors_of_current_user, only: [:new, :index]

  def show
    @message = Message.new
  end

end
