FactoryBot.define do
  factory :item do
    seller { nil }
    category { nil }
    name { "MyString" }
    description { "MyText" }
    images { "MyText" }
    starting_price { 1.5 }
    current_price { 1.5 }
    buy_it_now_price { 1.5 }
    start_date { "2024-02-16 09:29:12" }
    end_date { "2024-02-16 09:29:12" }
    status { "MyString" }
  end
end
