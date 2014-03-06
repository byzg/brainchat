class AddFieldsToMessage < ActiveRecord::Migration
  def up
    add_column :messages, :user_id, :integer
    add_column :messages, :incomer_subject, :string
    remove_column :messages, :updated_at
  end
  def down
    remove_column :messages, :user_id
    remove_column :messages, :incomer_subject
    add_column :messages, :updated_at, :datetime
  end
end
