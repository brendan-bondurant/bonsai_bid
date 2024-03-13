FactoryBot.define do
  factory :item do
    association :seller, factory: :user
    association :category, factory: :category
    name { "name" }
    description { Faker::Lorem.paragraph }
    # images { Faker::LoremPixel.image } 
    starting_price { Faker::Commerce.price(range: 0..100.0, as_string: true) }
    current_price { starting_price } 
    buy_it_now_price { Faker::Commerce.price(range: 0..200.0, as_string: true) }
    start_date { Faker::Time.between(from: DateTime.now - 10, to: DateTime.now) } 
    status { 'listed' }
    end_date { Faker::Time.between(from: DateTime.now, to: DateTime.now + 10) } 
  end
end
# status { ['listed', 'active', 'sold', 'ended'].sample }
