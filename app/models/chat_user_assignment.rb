class ChatUserAssignment < ActiveRecord::Base
  # attr_accessible :user
  belongs_to :chat
  belongs_to :user

end
