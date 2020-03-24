class ItemsController < ApplicationController

  before_action :set_item, only: [:show, :edit, :destroy, :update, :purchase]
  before_action :set_category, except: [:create, :destroy, :category_grandchildren]
  before_action :redirect_login, except: [:index, :show]
  before_action :redirect_show_from_purchase, only: [:purchase, :pay]
  before_action :redirect_show_from_edit, only: [:edit, :update, :destroy]

  require 'payjp'
  def index
    @items = Item.includes(:user).limit(3)
    @parents = Category.where(ancestry: nil)

  end

  def new
    @item = Item.new
    @category = Category.all.order("id ASC").limit(13)
    @category_parent_array = Category.roots.pluck(:name)
    @item.images.build()
    @item.build_brand
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      redirect_to new_item_path
    end
  end

  def show
    @items = Item.includes(:user)
  end

  # 購入確認
  def purchase
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

      begin
        # Use Payjp's library to make requests...
        charge = Payjp::Charge.create(
        amount: @item.price,
        customer: card.customer_id,
        currency: 'jpy'
        )

      rescue Payjp::CardError => e
        # Since it's a decline, Payjp::CardError will be caught
        body = e.json_body
        err  = body[:error]
        puts "Status is: #{e.http_status}"
        puts "Type is: #{err[:type]}"
        puts "Code is: #{err[:code]}"
        # param is '' in this case
        puts "Param is: #{err[:param]}"
        puts "Message is: #{err[:message]}"

      rescue Payjp::InvalidRequestError => e
        # Invalid parameters were supplied to Payjp's API
      rescue Payjp::AuthenticationError => e
        # Authentication with Payjp's API failed
        # (maybe you changed API keys recently)
      rescue Payjp::APIConnectionError => e
        # Network関連でエラーが発生した場合の例外
        # ex1, PAY.JPが障害中などでサーバーとのコネクションが切れた場合
        # ex2, api.pay.jpの名前解決に失敗した場合
        # ex3, リクエストからレスポンス受信までに90秒以上経過した場合
        # => 3の場合リクエストが成功している可能性があるため、成否を確認下さい
        # => 3の秒数は`Payjp.read_timeout = 100`のように任意に設定可能です
      rescue Payjp::APIError => e
        # 上記以外の特殊なケースの例外
        # ex, レスポンスのボディがJSON形式でない場合(PAY.JP障害時など)
        # ex, レスポンスのHTTPステータスが400,401,402,404以外の場合
      rescue Payjp::PayjpError => e
        # PayjpErrorは上記5種類の独自例外クラスの親クラスです
        # 本SDK内ではこの例外を直接raiseしておりません
        # 上記5種類の独自例外クラスを包括的にrescueする目的でご利用下さい
      rescue => e
        # Something else happened, completely unrelated to Payjp
      end

      if e
        redirect_to purchase_path, alert: "購入に失敗しました。カード情報を確認してください"
      elsif Item.where(id: @item.id).update_all(buyer_id: current_user.id)
        redirect_to action: 'done'
      else
        render :purchase
      end

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
    item_category = Category.find("#{@item.category_id}")
    @category_parent_array = Category.roots.pluck(:name)
    @category_parent_name = item_category.root.name
    @category_children_siblings = item_category.parent.siblings
    @category_children_name = item_category.parent.name
    @category_grandchildren_name = item_category.name
    @category_grandchildren_siblings = item_category.siblings
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      redirect_to edit_item_path, alert: "更新に失敗しました"
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

  def redirect_login
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "ログインしてください"
    end
  end

  def redirect_show_from_purchase
    if (@item.user_id == current_user.id) || (@item.buyer_id.present?)
      redirect_to item_path, alert: "不正なリクエストです"
    end
  end

  def redirect_show_from_edit
    unless @item.user_id == current_user.id
      redirect_to item_path, alert: "不正なリクエストです"
    end
  end

end