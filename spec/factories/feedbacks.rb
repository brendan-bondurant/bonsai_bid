FactoryBot.define do
  factory :feedback do
    item { nil }
    from_user { nil }
    to_user { nil }
    rating { 1 }
    comment { "MyText" }
    feedback_time { "2024-02-16 09:29:28" }
  end
end
