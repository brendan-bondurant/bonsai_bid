FactoryBot.define do
  factory :bid do
    association :auction
    association :bidder, factory: :user
    bid_amount { Faker::Commerce.price(range: 1.0..100.0) }
  end
end
