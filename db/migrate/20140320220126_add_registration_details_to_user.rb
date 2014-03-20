class AddRegistrationDetailsToUser < ActiveRecord::Migration
  def up
    add_column :users, :registration_details, :text
  end
  def down
    remove_column :messages, :registration_details
  end
end
