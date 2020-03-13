class ItemsController < ApplicationController

  require 'payjp'

  def index
    @items = Item.includes(:user)
  end

  def new
    @item = Item.new
  end

  def create
    item.create(item_params)
  end

  def show
    @item = Item.find(params[:id])
  end

  # 購入確認
  def purchase
    @item = Item.find(params[:id])
    # FIXME: itemテーブルから画像取得
    # @image = @item.images.first
    card = CreditCard.where(user_id: current_user.id).first
    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_id)
      @customer_card = customer.cards.retrieve(card.card_id)
    end
  end

 # 購入完了
  def done
  end

  # 購入
  def pay
    card = CreditCard.where(user_id: current_user.id).first
    if card.blank?
      redirect_to controller: "credit_cards", action: "new"
    else
      @item = Item.find(params[:id])
      Payjp.api_key = Rails.application.credentials.PAYJP_SECRET_KEY
      charge = Payjp::Charge.create(
      amount: @item.price,
      customer: card.customer_id,
      currency: 'jpy'
      )
      Item.where(id: @item.id).update_all(buyer_id: current_user.id)
      redirect_to action: 'done'
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
  end

  private
  def item_params
    params.require(:item).permit(
       :name,
       :description,
       :status,
       :fee_side,
       :prefectures,
       :shipping_days,
       :price,
       :size,
       :brand_id ,
       :saler_id ,
       :category_id
    ).merge(
       buyer_id: current_user.id,
    )
  end


end
