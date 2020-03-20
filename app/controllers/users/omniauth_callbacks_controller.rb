# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    authorization :facebook
  end

  def google_oauth2
    authorization
  end

  def failure
    redirect_to root_path
  end

  private

  def authorization
    # APIから受け取ったレスポンスがrequest.env["omniauth.auth"]という変数に入る
    sns_info = User.from_omniauth(request.env["omniauth.auth"])
    @user = sns_info[:user]
    if @user.persisted?#ユーザー情報が登録済みなので、新規登録ではなくログイン処理を行う
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
    else#ユーザー情報が未登録なので、新規登録画面へ遷移する
      @sns_id = sns_info[:sns].id  #＠sns_idという変数を作り、新規登録画面で扱えるようにする
      render template: 'devise/registrations/new'
    end
  end
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
