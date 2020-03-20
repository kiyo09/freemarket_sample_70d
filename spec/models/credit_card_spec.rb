require 'rails_helper'

describe CreditCard do
  describe '#create' do
    it "is invalid without an user_id" do
      creditCard = build(:creditCard, user_id: nil)
      
      creditCard.valid?
      expect(creditCard.errors[:user_id]).to include("を入力してください")
    end

    it "is invalid without a customer_id" do
      creditCard = build(:creditCard, customer_id: nil)
      creditCard.valid?
      expect(creditCard.errors[:customer_id]).to include("を入力してください")
    end

    it "is invalid without a card_id" do
      creditCard = build(:creditCard, card_id: nil)
      creditCard.valid?
      expect(creditCard.errors[:card_id]).to include("を入力してください")
    end
  end
end