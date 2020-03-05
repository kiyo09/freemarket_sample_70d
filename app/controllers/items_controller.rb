class ItemsController < ApplicationController

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
       :size
    ).merge(
       brand_id: ,
       saler_id: ,
       buyer_id: current_user.id,
       category_id:
    )
  end

end
