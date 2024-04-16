# spec/factories/transactions.rb
FactoryBot.define do
  factory :sale_transaction do
    association :buyer, factory: :user
    association :seller, factory: :user
    association :item, factory: :item
    final_price { Faker::Commerce.price(range: 0..200.0, as_string: true) }
    payment_status { ['incomplete', 'pending', 'complete'].sample }
  end
end
