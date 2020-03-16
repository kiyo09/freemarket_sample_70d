class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :destroy, :update]
  before_action :set_category, except: [:create, :destroy, :category_grandchildren]

  require 'payjp'
  def index
    @items = Item.includes(:user).limit(6)
    @parents = Category.where(ancestry: nil)

  end

  def new
    @item = Item.new
    @category = Category.all.order("id ASC").limit(13)
    @category_parent_array = Category.roots.pluck(:name)
    @item.images.build
    @item.build_brand
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @items = Item.includes(:user)
  end

  # 購入確認
  def purchase
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
    item.destroy
  end

  def edit
  end

  def update
    item.update(item_params)
  end

  def search
    respond_to do |format|
      format.html
      format.json do
       @children = Category.find(params[:parent_id]).children
       #親ボックスのidから子ボックスのidの配列を作成してインスタンス変数で定義
      end
    end
  end
  
  def category_children  
    @category_children = Category.find_by(name: "#{params[:productcategory]}").children 
  end
  # Ajax通信で送られてきたデータをparamsで受け取り､childrenで子を取得

  def category_grandchildren
    @category_grandchildren = Category.find("#{params[:productcategory]}").children
  end

  private
  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :status_id,
      :fee_side_id,
      :prefecture_id,
      :shipping_days_id,
      :price,
      :size_id,
      :buyer_id,
      :category_id,
      brand_attributes: [:id, :name],
      images_attributes: [:id, :image, :_destroy]
    )
    .merge(
       user_id: current_user.id
    )
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_category
    @category = Category.all.order("id ASC").limit(13)
  end


end