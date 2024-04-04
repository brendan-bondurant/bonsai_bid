FactoryBot.define do
  factory :user_profile do
    user { nil }
    name { "MyString" }
    address { "MyText" }
    phone { "MyString" }
  end
end
