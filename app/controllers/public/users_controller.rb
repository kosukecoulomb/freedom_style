class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @search_params = user_search_params
    @users = User.search(@search_params)
  end

  def my_page
    @user = current_user
    @coordinates = Coordinate.where(user_id: @user.id)
    # おすすめコーデの表示 scopeでcoordinateモデルにlatestメソッド、userモデルにsimilarメソッド定義
    @recommendations = Coordinate.joins(:user).merge(User.similar(@user)).latest(3)
    # いいねしたコーデ表示 scopeでcoordinateモデルにmy_favoriteメソッド定義
    @favorite_coordinates = Coordinate.latest(3).my_favorites(@user)
    # フォローしているユーザーの投稿
    @following_coordinates = Coordinate.latest(3).where(user_id: [*@user.following_ids])
    # トレンドタグの表示
    @tag_list = Tag.popularity(3)
  end

  def favorites
    @favorite_coordinates = Coordinate.order(created_at: :desc).my_favorites(current_user)
  end

  def show
    @user = User.find(params[:id])
    @coordinates = @user.coordinates.all
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "プロフィールの更新に成功しました"
    else
      render :edit
    end
  end

  def unsubscribe
    @user = current_user
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path
    flash[:notice] = "アカウントを削除しました"
  end

  # フォロー・フォロワーを表示
  def followings
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction, :gender, :generation, :tall, :body_shape, :foot_size)
  end

  # ゲストユーザー機能
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to my_page_path(current_user)
      flash[:notice] = 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def user_search_params
    params.fetch(:search, {}).permit(:gender, :generation, :body_shape, :tall_from, :tall_to, :keyword)
  end


end
