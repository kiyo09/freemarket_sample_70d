# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new(sign_up_params)
  
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @user_details = @user.build_user_detail
    render :new_user_detail
  end

  def create_user_detail
    @user = User.new(session["devise.regist_data"]["user"])
    @user_detail = UserDetail.new(user_detail_params)
    # binding.pry
    unless @user_detail.valid?
      flash.now[:alert] = @user_detail.errors.full_messages
      render :new and return
    end
    @user.build_user_detail(@user_detail.attributes)
    if @user.save
    sign_in(:user, @user)
    else
      render :new
    end
  end


  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  def user_detail_params
    params.require(:user_detail).permit(
      :first_name,
      :first_name_kana,
      :last_name,
      :last_name_kana,
      :birthday,
      :desination_name,
      :desination_kana,
      :post_code,
      :prefectures,
      :mayor,
      :address,
      :building,
      :phone_no
      # user_detail_attributes: [:id]
    )
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
