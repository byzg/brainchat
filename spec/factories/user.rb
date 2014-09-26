FactoryGirl.define do
  factory :user, class: User do
    sequence              (:email)  {|n| "user#{n}@mail.com" }
    sequence              (:name)   {|n| "user#{n}" }
    password                        'qwe321'
    password_confirmation           'qwe321'
  end

end