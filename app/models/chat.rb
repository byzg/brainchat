class Chat < ActiveRecord::Base
  attr_accessible :subject
  has_many :messages
  has_many :chat_user_assignments
  has_many :users, through: :chat_user_assignments

  #validate :users, presence: true

  #def must_has_more_then_one_user
  #
  #end
end
