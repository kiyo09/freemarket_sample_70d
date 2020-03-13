FactoryBot.define do
  factory :image do
    id                    {"1"}
    image                 {File.open("#{Rails.root}/app/assets/images/logo.png")}
    association  :item, factory: :item
  end
end