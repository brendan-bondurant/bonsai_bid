FactoryBot.define do
  factory :reply do
    content { Faker::Lorem.paragraph(sentence_count: 2) }
    association :feedback
  end
end
