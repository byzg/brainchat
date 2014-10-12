module ChatHelper

  def details_hash
    messages = Message.available_messages(@chat, current_user)
    messages_count = messages.try(:count).to_i
    result = {
        Chat.human_attribute_name('created_at') => @chat.created_at,
        t('.owner') => @chat.owner.name,
        t('.messages_count') => messages_count,
    }
    if messages_count > 0
      last_message_created_at = messages.last.created_at
      result.merge!(t('.last_message_created_at') => last_message_created_at)
    end
    result
  end

end