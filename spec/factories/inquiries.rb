FactoryBot.define do
  factory :inquiry do
    commenter_id { "" }
    seller_id { "" }
    item_id { "" }
    comment { "MyText" }
    parent_id { 1 }
  end
end
