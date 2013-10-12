class UsersController < InheritedResources::Base

  #respond_to :js, :only => [:new]
  def create
    super do |format|
      format.html { redirect_to root_path }
    end
  end


end
