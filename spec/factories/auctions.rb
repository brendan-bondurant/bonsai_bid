FactoryBot.define do
  factory :auction do
    association :item
    association :seller, factory: :user
    start_date { Faker::Time.between(from: DateTime.now - 3.days, to: DateTime.now - 2.days) }
    end_date { Faker::Time.between(from: DateTime.now + 1.day, to: DateTime.now + 5.day) }
    starting_price { Faker::Commerce.price(range: 1.0..100.0) }
    buy_it_now_price { Faker::Commerce.price(range: 100.0..200.0) }
    bid_increment { Faker::Commerce.price(range: 1.0..5.0) }
    status { ['listed', 'active', 'sold', 'ended'].sample }
  end
end
