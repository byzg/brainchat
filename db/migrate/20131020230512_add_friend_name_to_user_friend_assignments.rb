class AddFriendNameToUserFriendAssignments < ActiveRecord::Migration
  def change
    add_column :user_friend_assignments, :friend_name, :string
  end
end
