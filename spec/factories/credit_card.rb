# module CreditCard
#   def self.creditCard_information # Payjp::Customerのレスポンスモック
FactoryBot.define do
  factory :creditCard do
    user_id{"4"}
    customer_id {"cus_ca9d1d98900ec1f2595aebefd9a6"}
    card_id{"car_a96c76b044d7ae21439d7b9840b7"}
  end
end

