require 'rails_helper'

describe Item do
  describe '商品出品機能' do


    it "is invalid without a name" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    #nameの文字が40文字以上と以下の場合
    it "is invalid name is too long maximum 40 characters" do
      item = build(:item, name: "a" * 41)
      item.valid?
      expect(item.errors[:name]).to include("is too long (maximum is 40 characters)")
    end

    it "is invalid without a description" do
      item = build(:item, description: nil)
      item.valid?
      expect(item.errors[:description]).to include("can't be blank")
    end

    #descriptionの文字が1000文字以上と以下の場合
    it "is invalid description is too long maximum 40 characters" do
      item = build(:item, description: "a" * 1001)
      item.valid?
      expect(item.errors[:description]).to include("is too long (maximum is 1000 characters)")
    end

    it "is valid with a description that has less than 1000 characters" do
      item = FactoryBot.build(:item, description: "a" * 1000)
      expect(item).to be_valid
    end

    it "is invalid without a status_id" do
      item = build(:item, status_id: nil)
      item.valid?
      expect(item.errors[:status_id]).to include("can't be blank")
    end

    it "is invalid without a fee_side_id" do
      item = build(:item, fee_side_id: nil)
      item.valid?
      expect(item.errors[:fee_side_id]).to include("can't be blank")
    end

    it "is invalid without a shipping_days_id" do
      item = build(:item, shipping_days_id: nil)
      item.valid?
      expect(item.errors[:shipping_days_id]).to include("can't be blank")
    end

    it "is invalid without a prefecture_id" do
      item = build(:item, prefecture_id: nil)
      item.valid?
      expect(item.errors[:prefecture_id]).to include("can't be blank")
    end

    it "is invalid without a price" do
      item = build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("can't be blank")
    end

    #priceが9999999円以上の場合
    it "is invalid price is too much maximum 9999999" do
      item = build(:item, price: 10000000)
      item.valid?
      expect(item.errors[:price]).to include("is not included in the list")
    end

    #priceが9999999円の場合
    it "is valid price is too much maximum 9999999" do
        item = build(:item, price: 9999999)
        expect(item).to be_valid
    end

    #priceが300円以下の場合
    it "is invalid with a that has less than 300" do
        item = build(:item, price: 299)
        item.valid?
        expect(item.errors[:price]).to include("is not included in the list")
    end

    #priceが300円の場合
    it "is valid with a that has less than 300" do
        item = build(:item, price: 300)
        expect(item).to be_valid
    end

    it "is invalid without a buyer_id" do
      item = build(:item, buyer_id: nil)
      item.valid?
      expect(item.errors[:buyer_id]).to include("can't be blank")
    end

    it "is invalid without a category_id" do
      item = build(:item, category_id: nil)
      item.valid?
      expect(item.errors[:category_id]).to include("can't be blank")
    end

  end
end

