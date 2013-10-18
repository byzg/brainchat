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
  has_many :chat_user_assignments
  has_many :chats, through: :chat_user_assignments
  has_many :user_friend_assignments
  has_many :friends, :through => :user_friend_assignments
end
