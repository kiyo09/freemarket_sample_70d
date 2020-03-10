class ItemsController < ApplicationController

  def index
    @items = Item.includes(:user)
  end

  def new
    @item = Item.new
    # @item.images.new
    # @item.build_brand
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
    @item = Item.find(params[:id])
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
      :image,
      :name,
      :description,
      :status_id,
      :fee_side_id,
      :prefecture_id,
      :shipping_days_id,
      :price,
      :size_id,
      :brand_id,
      :saler_id,
      :category_id
    )
    # ).merge(
    #   # prefecture: params[:address]
    #   #  buyer_id: current_user.id
    # )
  end


end
