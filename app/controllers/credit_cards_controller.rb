class CreditCardsController < ApplicationController
  require 'payjp'
  before_action :set_card

  def index
    card = current_user.credit_card
    if card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = Rails.application.credentials.PAYJP_SECRET_KEY
      customer = Payjp::Customer.retrieve(card.customer_id)
      @customer_card = customer.cards.retrieve(card.card_id)
    end
  end

  # クレジットカード情報登録画面
  def new
    if @creditCard
      redirect_to credit_cards_path unless @creditCard
      render 'credit_cards' unless @creditCard
    end
  end

  # 登録画面で入力した情報をDBに保存
  def create
    Payjp.api_key = Rails.application.credentials.PAYJP_SECRET_KEY
    if params['payjp-token'].blank?
      # TODO: 遷移先相談
      redirect_to credit_cards_path
    else
      customer = Payjp::Customer.create( # ここで先ほど生成したトークンを顧客情報と紐付け、PAY.JP管理サイトに送信
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @creditCard = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @creditCard.save
        redirect_to credit_cards_path
      else
        begin
          # Use Payjp's library to make requests...
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
        redirect_to credit_cards_path
      end
    end
  end


  def destroy
    card = current_user.credit_card
    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "index", id: current_user.id
  end

  private

  def set_card
    @creditCard = CreditCard.where(user_id: current_user.id).first if CreditCard.where(user_id: current_user.id).present?
  end
end
