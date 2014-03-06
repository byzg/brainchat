class AddFieldsToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :user_id, :integer
    add_column :messages, :incomer_subject, :string
  end
end
