FactoryBot.define do
  factory :reply do
    content { Faker::Lorem.paragraph(sentence_count: 2) }

    association :author, factory: :user
    trait :for_feedback do
      association :respondable, factory: :feedback
    end

    trait :for_inquiry do
      association :respondable, factory: :inquiry
    end
  end
end
