FactoryBot.define do
  factory :item do
    association :seller, factory: :user
    association :category, factory: :category
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
  end
end
