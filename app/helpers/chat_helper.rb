module ChatHelper

  def details_hash_default
    first_chat = collection.first
    messages_of_first_chat = Message.available_messages(first_chat, current_user)
    last_message = messages_of_first_chat.try(:last).try(:created_at) || "-"
    {
        Chat.human_attribute_name('created_at') => first_chat.created_at,
        t('.details.owner') => first_chat.owner.name,
        t('.details.messages_count') => messages_of_first_chat.try(:count).to_i,
        t('.details.last_message') => last_message
    }
  end

end