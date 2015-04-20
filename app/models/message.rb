class Message < ActiveRecord::Base
  # attr_accessible :text, :incomer_subject, :user_id, :chat_id

  belongs_to :chat
  belongs_to :user
  validates :text, :user_id, :chat_id, presence: true
  scope :available_messages, lambda { |chat, user| user.is_owner?(chat) ? chat.messages : chat.messages.where(user_id: [user.id, chat.owner_id]).sort_by(&:created_at) }

  def text
    super.gsub("\n", "<br>").html_safe
  end

end
