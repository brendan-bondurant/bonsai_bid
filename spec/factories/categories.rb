FactoryBot.define do
  factory :category do
    name { "name" }
    description { Faker::ChuckNorris.fact }
    # parent_id { "" }
  end
end
