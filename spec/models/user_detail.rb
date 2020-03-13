require 'rails_helper'

describe UserDetail do
  describe '#create_user_detail' do

  # 1. first_nameが空では登録できないこと
  it "is invalid without a first_name" do
    user = build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end
    # it "is invalid without a first_name" do
    #   user_detail = build(:user_detail, first_name: nil)
    #   user_detail.valid?
    #   expect(user_detail.errors[:first_name]).to include("can't be blank")
    # end
  end
end