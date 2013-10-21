class ChatsController < InheritedResources::Base
  actions :index, :new, :create
  #respond_to :js, :only => :create
  def create
    params[:chat][:user_ids].concat(["#{current_user.id}"])
    create! do |success, failure|
      failure.html {return redirect_to :back, alert: resource.errors.full_messages }
    end
  end

  def show
    @message = Message.new
  end

end


