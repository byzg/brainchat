FactoryGirl.define do
  factory :message, class: Message do
    text          'Some text of message'
    association   :user, factory: :user
    association   :chat
  end

end