class CreateChatUserAssignments < ActiveRecord::Migration
  def change
    create_table :chat_user_assignments do |t|
      t.belongs_to :chat
      t.belongs_to :user
    end
  end
end
