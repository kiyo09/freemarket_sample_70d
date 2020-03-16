class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :destroy, :update]
  before_action :set_category, except: [:create, :destroy, :category_grandchildren]
  
  def index
    @items = Item.includes(:user).limit(6)
    @parents = Category.where(ancestry: nil)
  end

  def new
    @item = Item.new
    @category_parent_array = ["---"]
      Category.where(ancestry: nil).each do |parent|
         @category_parent_array << parent.name
      end
    @item.images.build
    @item.build_brand
    @category = Category.all.order("id ASC").limit(13)
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