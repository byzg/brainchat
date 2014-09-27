class UserFriendAssignment < ActiveRecord::Base
  # attr_accessible :user_id, :friend_id
  belongs_to :friend, :class_name => "User"
  validate :cannot_add_self
  validates :user_id, :uniqueness => {:scope => :friend_id}
  validates :user_id, :friend_id, presence: true
  private
  def cannot_add_self
    errors.add(:base, I18n.t('models_custom.user_friend_assignments.validation.cannot_add_self')) if self.user_id == self.friend_id
  end
end