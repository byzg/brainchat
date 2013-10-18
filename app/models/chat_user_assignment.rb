class ChatUserAssignment < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :chat
  belongs_to :user

end
