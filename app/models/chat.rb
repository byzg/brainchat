class Chat < ActiveRecord::Base
  attr_accessible :subject, :user_ids
  has_many :messages
  has_many :chat_user_assignments
  has_many :users, through: :chat_user_assignments
  validate :must_have_more_then_two_users
  after_create {
    update_attribute(:subject, I18n.t('models_custom.chat.before_create.subject_if_not_given', chat_id: id))
  }

  def user_ids=(user_ids)
    User.where(id: user_ids.to_a).each {|u| chat_user_assignments.build(user: u) }
  end

  def must_have_more_then_two_users
    errors.add(:base, I18n.t('models_custom.chat.validation.must_have_more_then_two_users')) if chat_user_assignments.size < 2
  end
end
