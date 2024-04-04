FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' } 
    password_confirmation { 'password' } 
    # phone {"1234567890"} 
    # address {"123 main street"} 
    # name {"user"}
  end
end
