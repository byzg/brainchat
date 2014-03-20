class UsersController < InheritedResources::Base
  actions :new, :create
  before_filter lambda{params[:user].merge!({password: SecureRandom.hex,
                                             registration_details: {created_by_user_id: current_user.id}})},
                only: :create

end
