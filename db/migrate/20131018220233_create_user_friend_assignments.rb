class CreateUserFriendAssignments < ActiveRecord::Migration
  def change
    create_table :user_friend_assignments do |t|
      t.integer :user_id
      t.integer :friend_id
      t.datetime :created_at
    end
  end
end
