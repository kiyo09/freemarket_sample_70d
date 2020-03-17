class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :destroy, :update, :purchase]
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
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def edit
    @items = Item.includes(:user)
    @parents = Category.where(ancestry: nil)
    @category_parent_array = Category.roots.pluck(:name)
    @category_parent_name = Category.find("#{@item.category_id}").root.name
    @category_children_name = Category.find("#{@item.category_id}").parent.name
    @category_grandchildren_name = Category.find("#{@item.category_id}").name



    # @grandchild = @item.category
    # @child = @grandchild.parent
    # @parent = @grandchild.parent.parent
    # @category_parent_array = ["---"]

    # Category.where(ancestry: @grandchild.ancestry).each do |grandchild|
    #   @category_grandchild_array << grandchild.name
    # end

    # @category_child_array = ["--"]
    # Categor.where(ancestry: @child.ancestry).ec


    # @parents = Category.where(ancestry:nil)
    # # 編集する商品を選択
    # @item = Item.find(params[:id])
    # # 登録されている商品の孫カテゴリーのレコードを取得
    # @selected_grandchild_category = @item.category
    # # 孫カテゴリー選択肢用の配列作成
    # @category_grandchildren_array = [{id: "---", name: "---"}]
    # Category.find("#{@selected_grandchild_category.id}").siblings.each do |grandchild|
    #   grandchildren_hash = {id: "#{grandchild.id}", name: "#{grandchild.name}"}
    #   @category_grandchildren_array << grandchildren_hash
    # end
    # # 選択されている子カテゴリーのレコードを取得
    # @selected_child_category = @selected_grandchild_category.parent
    # # 子カテゴリー選択肢用の配列作成
    # @category_children_array = [{id: "---", name: "---"}]
    # Category.find("#{@selected_child_category.id}").siblings.each do |child|
    #   children_hash = {id: "#{child.id}", name: "#{child.name}"}
    #   @category_children_array << children_hash
    # end
    # # 選択されている親カテゴリーのレコードを取得
    # @selected_parent_category = @selected_child_category.parent
    # # 親カテゴリー選択肢用の配列作成
    # @category_parents_array = [{id: "---", name: "---"}]
    # Category.find("#{@selected_parent_category.id}").siblings.each do |parent|
    #   parent_hash = {id: "#{parent.id}", name: "#{parent.name}"}
    #   @category_parents_array << parent_hash
    # end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item), notice: "商品を更新しました"
    else
      render :edit
    end
    
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