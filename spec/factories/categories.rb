# spec/factories/categories.rb
FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    description { "Category description" }

    trait :with_parent do
      association :parent, factory: :category
    end
  end
end
