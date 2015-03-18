class Chat < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  has_many :chat_user_assignments, dependent: :destroy
  has_many :users, through: :chat_user_assignments
  belongs_to :owner, class_name: 'User'
  validate :must_have_more_then_two_users
  validates :owner_id, :subject, presence: true
  attr_readonly :owner_id

  def user_ids=(user_ids)
    User.where(id: user_ids.to_a).each {|u| chat_user_assignments.build(user: u) }
  end

  def self.common_chats_of_user_friends(current_user, chat_fields = '*')
    chat_groups = Chat.where(id: current_user.chats)
      .joins(:chat_user_assignments)
      .where(chat_user_assignments: {user_id: current_user.friends.pluck(:id)})
      .select("chats.#{chat_fields}, chat_user_assignments.user_id AS user_id")
      .group_by {|x| x.user_id}.each {|_, v| v.map(&:id)}
    friends = current_user.friends.select('users.id, name, email')
    groups = {}
    friends.each {|f| groups[f] = chat_groups[f.id.to_s] }
    groups
  end

  private
  def must_have_more_then_two_users
    errors.add(:base, I18n.t('models_custom.chat.validation.must_have_more_then_two_users')) if chat_user_assignments.size < 2
  end
end
