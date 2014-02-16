class AddOwnerToChats < ActiveRecord::Migration
  def change
    add_column :chats, :owner_id, :integer
  end
end
