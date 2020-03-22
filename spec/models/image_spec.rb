require 'rails_helper'

describe Image do
  describe '商品出品機能' do

    # it "is invalid without a image" do
    #  image = Image.new(image: nil)
    #  image.valid?
    #  expect(image.errors[:image]).to include("can't be blank")
    # end

    it "is invalid without a image" do
      image = build(:image, image: nil)
      image.valid?
      expect(image.errors[:image]).to include("を入力してください")
     end

  end
end