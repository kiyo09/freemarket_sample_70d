class CreditCardsController < ApplicationController
  require 'payjp'
  before_action :set_card
  before_action :redirect_login

  def index
    card = current_user.credit_card
    if card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = Rails.application.credentials.PAYJP_SECRET_KEY
      customer = Payjp::Customer.retrieve(card.customer_id)
      @customer_card = customer.cards.retrieve(card.card_id)
    end
  end

  # クレジットカード情報登録画面
  def new
    if @creditCard
      redirect_to credit_cards_path
    end
  end

  # 登録画面で入力した情報をDBに保存
  def create
    Payjp.api_key = Rails.application.credentials.PAYJP_SECRET_KEY

    if params['payjp-token'].blank?
      redirect_to credit_cards_path
    else
      customer = Payjp::Customer.create( # ここで先ほど生成したトークンを顧客情報と紐付け、PAY.JP管理サイトに送信
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @creditCard = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)

      if @creditCard.save
        redirect_to credit_cards_path
      else
        redirect_to new_credit_card_path
      end
    end
  end


  def destroy
    card = current_user.credit_card
    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "index", id: current_user.id
  end

  private

  def set_card
    @creditCard = CreditCard.where(user_id: current_user.id).first if CreditCard.where(user_id: current_user.id).present?
  end

  def redirect_login
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "ログインしてください"
    end
  end

end
