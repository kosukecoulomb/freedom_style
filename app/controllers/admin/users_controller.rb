class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @coordinates = @user.coordinates.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
      flash[:notice]="ユーザーステータスを変更"
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:is_deleted)
  end

end
