FactoryBot.define do
  factory :bid do
    association :auction
    association :bidder, factory: :user
    bid_amount { Faker::Commerce.price(range: 1.0..100.0) }
    bid_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
  end
end
