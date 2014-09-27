class User < ActiveRecord::Base
  DETAILS_FIELD = :registration_details
  DETAILS_ACCESSIBLE = [:created_by_user_id]
  include HashFieldAccessor

  # :token_authenticatable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # attr_protected :registration_details
  validates :password, format: { with: /\A[a-zA-Z0-9.-]+\z/ }
  validates :name, presence: true
  has_many :chat_user_assignments
  has_many :chats, through: :chat_user_assignments
  has_many :user_friend_assignments
  has_many :friends, through: :user_friend_assignments
  has_many :messages
  scope :all_except, lambda{|user| user ? {conditions: ["id != ?", user.id]} : {} }
  scope :not_friends_for, lambda{|user| user ? User.all - user.friends - [user] : {} }
  def have_friends?
    friends.presence != nil
  end
  def have_chat?(chat_or_id)
    chats.find_by_id(chat_or_id.instance_of?(Chat) ? chat_or_id.id : chat_or_id) != nil
  end
  def is_owner?(chat)
    id == chat.owner_id
  end
  def can_send_messages_to?(user)
    true      #                   ЗАГЛУШКА!!!
  end
  def creator
    User.find_by_id(created_by_user_id) || self
  end
  def self_created?
    created_by_user_id == id || created_by_user_id.nil?
  end
  def creator_id=(id)
    created_by_user_id = id
  end

end
