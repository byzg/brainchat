class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :name

  validates :password, :format => { :with => /^[a-zA-Z0-9.-]+$/  }
  validates :name, :email, :password, presence: true
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

end
