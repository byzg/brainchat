class Message < ActiveRecord::Base
  attr_accessible :text

  belongs_to :chat
  validates :text, presence: true
end
