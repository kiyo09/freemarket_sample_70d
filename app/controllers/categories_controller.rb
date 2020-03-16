class CategoriesController < ApplicationController
  def index
    @categories = Category.all.order("id ASC").limit(13)
  end

  def show
    @categorie = Category.find(params[:id])
  end

  def new
    @categories = Category.where(ancestry: params[:id])
    respond_to do |format|
      format.json
    end
  end
    

end
