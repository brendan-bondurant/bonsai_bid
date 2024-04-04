FactoryBot.define do
  factory :auction do
    item { nil }
    start_date { "2024-04-04 09:51:01" }
    end_date { "2024-04-04 09:51:01" }
    starting_price { 1.5 }
    buy_it_now_price { 1.5 }
    bid_increment { 1.5 }
  end
end
