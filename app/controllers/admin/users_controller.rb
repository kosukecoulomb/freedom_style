class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @search_params = user_search_params
    @users = User.search(@search_params)
  end

  def show
    @user = User.find(params[:id])
    @coordinates = @user.coordinates.all
    @items = @user.items.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
      flash[:notice] = "ユーザーステータスを変更"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:is_deleted)
  end

  def user_search_params
    params.fetch(:search, {}).permit(:keyword)
  end
end
