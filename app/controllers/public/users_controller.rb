class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def my_page
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @coordinates = @user.coordinates.all
    #@items = @user.coordinates_items
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to my_page_path
      flash[:notice] = "プロフィールの更新に成功しました"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction, :gender, :generation, :tall, :body_shape, :foot_size)
  end

end
