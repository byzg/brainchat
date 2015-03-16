FactoryGirl.define do
  factory :chat, class: Chat do
    subject       'ChatSubject'
    association   :owner, factory: :user
  end

end