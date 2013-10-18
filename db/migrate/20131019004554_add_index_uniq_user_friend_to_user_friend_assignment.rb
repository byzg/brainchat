class AddIndexUniqUserFriendToUserFriendAssignment < ActiveRecord::Migration
  def change
    add_index :user_friend_assignments, [:user_id, :friend_id ], :unique => true
  end
end
