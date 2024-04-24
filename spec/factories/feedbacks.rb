FactoryBot.define do
  factory :feedback do
    association :auction
    association :from_user, factory: :user
    association :to_user, factory: :user
    association :sale_transaction
    rating { Faker::Number.between(from: 1, to: 5) }
    comment { Faker::Lorem.sentence(word_count: 10) }
  end
end
