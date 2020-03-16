class CategoriesController < ApplicationController
  def index
    @categories = Category.all.order("id ASC").limit(13)
    @parents = Category.all.order("id ASC").limit(13)
    # @children = Category.find(params[:parent_id]).children
    #   respond_to do |format|
    #     format.html
    #     format.json
    #   end
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
