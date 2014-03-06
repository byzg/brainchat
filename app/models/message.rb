class Message < ActiveRecord::Base
  attr_accessible :text, :incomer_subject, :user_id, :chat_id

  belongs_to :chat
  belongs_to :user
  validates :text, :user_id, :chat_id, presence: true
end
