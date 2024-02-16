FactoryBot.define do
  factory :user do
    email { "MyString" }
    password_digest { "MyString" }
    name { "MyString" }
    address { "MyText" }
    phone { "MyString" }
  end
end
