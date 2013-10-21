class ChatsController < InheritedResources::Base
  actions :index, :new, :create
  #respond_to :js, :only => :create
  def create
    super
    resource.users << current_user
  rescue => e
    return redirect_to :back, alert: e.message
  end

  def show
    @message = Message.new
  end

end


