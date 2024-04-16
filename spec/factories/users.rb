FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' } 
    password_confirmation { 'password' } 
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr } 
    zip { Faker::Address.zip_code }

    after(:create) do |user|
      create(:user_profile, user: user)
    end

  end
end
