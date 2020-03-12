class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]

  def index
    @items = Item.includes(:user)
  end

  def new
    @item = Item.new
    @item.images.build
    @item.build_brand
    @category = Category.all.order("id ASC").limit(13)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      # params[:item_images][:image].each do |image|
      # @item.item_images.create(image: image, item_id: @item.id)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def destroy
    item.destroy
  end

  def edit
  end

  def update
    item.update(item_params)
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
      :saler_id,
      :category_id,
      brand_attributes: [:id, :name],
      images_attributes: [:id, :image, :_destroy]
    )
    .merge(
      # prefecture: params[:address]
       buyer_id: current_user.id
    )
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
