FactoryBot.define do
  factory :user_profile do
    user
    phone { Faker::Number.number(digits: 10).to_s }  
    address {Faker::Address.street_address} 
    name { Faker::Name.name }
  end
end
