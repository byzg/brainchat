class Chat < ActiveRecord::Base
  attr_accessible :subject, :user_ids
  has_many :messages
  has_many :chat_user_assignments
  has_many :users, through: :chat_user_assignments

  def user_ids=(user_ids)
    users = User.where(id: user_ids.to_a)
  raise "косяк, браток!" if users.count < 2
    users.each {|u| chat_user_assignments.build(user: u) }
  end
end
