class Chat < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :messages
  has_many :chat_user_assignments
  has_many :users, through: :chat_user_assignments
end
