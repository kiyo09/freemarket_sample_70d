FactoryBot.define do
  factory :item do
    user_id               {"1"}
    id                    {"1"}
    name                  {"take"}
    description           {"この商品は格別です。"}
    status_id             {"1"}
    fee_side_id           {"2"}
    shipping_days_id      {"3"}
    prefecture_id         {"5"}
    price                 {"4000"}
    buyer_id              {"1"}
    category_id           {"2"}
    brand_id              {"2"}
    after(:build) do |item|
      item.images<< build(:image, item: item)
    end
  end
end