class AddSubjectToChats < ActiveRecord::Migration
  def change
    add_column :chats, :subject, :string
  end
end
