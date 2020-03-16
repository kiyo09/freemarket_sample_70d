require 'rails_helper'

describe UserDetail do
  describe '#create_user_detail' do
  # 1. first_nameが空では登録できないこと
    it "is invalid without a first_name" do
      user_detail = build(:user_detail, first_name: "")
      user_detail.valid?
      expect(user_detail.errors[:first_name]).to include("can't be blank")
    end

    it "is invalid without a first_name_kana" do
      user_detail = build(:user_detail, first_name_kana: nil)
      user_detail.valid?
      expect(user_detail.errors[:first_name_kana]).to include("can't be blank")
    end

     # 1. last_nameが空では登録できないこと
     it "is invalid without a last_name" do
      user_detail = build(:user_detail, last_name: "")
      user_detail.valid?
      expect(user_detail.errors[:last_name]).to include("can't be blank")
    end


    # last_name_kanaが空では登録できないこと
    it "is invalid without a last_name_kana" do
      user_detail = build(:user_detail, last_name_kana: nil)
      user_detail.valid?
      expect(user_detail.errors[:last_name_kana]).to include("can't be blank")
    end

    #  birthdayが空では登録できないこと
    it "is invalid without a birthday" do
      user_detail = build(:user_detail, birthday: nil)
      user_detail.valid?
      expect(user_detail.errors[:birthday]).to include("can't be blank")
    end

   # desination_nameが空では登録できないこと
    it "is invalid without a desination_name" do
      user_detail = build(:user_detail, desination_name: nil)
      user_detail.valid?
      expect(user_detail.errors[:desination_name]).to include("can't be blank")
    end

    # desination_kanaが空では登録できないこと
    it "is invalid without a desination_kana" do
      user_detail = build(:user_detail, desination_kana: nil)
      user_detail.valid?
      expect(user_detail.errors[:desination_kana]).to include("can't be blank")
    end

     # post_codeが空では登録できないこと
     it "is invalid without a post_code" do
      user_detail = build(:user_detail, post_code: nil)
      user_detail.valid?
      expect(user_detail.errors[:post_code]).to include("can't be blank")
    end

    # prefecturesが空では登録できないこと
    it "is invalid without a prefectures" do
      user_detail = build(:user_detail, prefectures: nil)
      user_detail.valid?
      expect(user_detail.errors[:prefectures]).to include("can't be blank")
    end

    # mayorが空では登録できないこと
    it "is invalid without a mayor" do
      user_detail = build(:user_detail, mayor: nil)
      user_detail.valid?
      expect(user_detail.errors[:mayor]).to include("can't be blank")
    end

    # addressが空では登録できないこと
    it "is invalid without a address" do
      user_detail = build(:user_detail, address: nil)
      user_detail.valid?
      expect(user_detail.errors[:address]).to include("can't be blank")
    end
  end

  describe '#katakana' do
    # last_name_kanaがカタカナでないと登録できないこと
    it 'is valid with a last_name_kana' do
      user_detail = build(:user_detail, last_name_kana: "kana")
      user_detail.valid?
      expect(user_detail.errors[:last_name_kana]).to include("全角カタカナのみで入力して下さい")
    end
# first_name_kanaがカタカナでないと登録できないこと
    it 'is valid with a first_name_kana' do
      user_detail = build(:user_detail, first_name_kana: "kana")
      user_detail.valid?
      expect(user_detail.errors[:first_name_kana]).to include("全角カタカナのみで入力して下さい")
    end
# desination_kanaがカタカナでないと登録できないこと
    it 'is valid with a desination_kana' do
      user_detail = build(:user_detail, desination_kana: "kana")
      user_detail.valid?
      expect(user_detail.errors[:desination_kana]).to include("全角カタカナのみで入力して下さい")
    end
  end
end