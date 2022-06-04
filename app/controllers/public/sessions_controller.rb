# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
   
    def after_sign_in_path_for(resource)
      mypage_path
    end

    def after_sign_out_path_for(resource)
      root_path
    end
  
    def reject_inactive_customer
      @user = user.find_by(email: params[:user][:email])
      if @user
        if @user.valid_password?(params[:user][:password]) && !@user.is_active
          flash[:danger] = '退会済みです。申し訳ございませんが、別のメールアドレスをお使いください。'
          redirect_to new_user_session_path
        end
      end
    end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
