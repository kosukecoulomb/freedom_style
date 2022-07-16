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
    # おすすめコーデの表示
    more_short = current_user.tall.to_i - 4
    more_tall = current_user.tall.to_i + 5
    @recommendations = Coordinate.joins(:user).merge(User.where(tall: more_short..more_tall, gender: @user.gender)).
      limit(4).order(created_at: :desc).where.not(user_id: @user.id)
    # いいねしたコーデ表示
    favorites = Favorite.where(user_id: @user.id).pluck(:coordinate_id)
    @favorite_coordinates = Coordinate.limit(4).order(created_at: :desc).find(favorites)
    # フォローしているユーザーの投稿
    @following_coordinates = Coordinate.limit(4).order(created_at: :desc).where(user_id: [*current_user.following_ids])
    # トレンドタグの表示
    @tag_list = Tag.limit(3).find(TagMap.group(:tag_id).order('count(coordinate_id) desc').pluck(:tag_id))
  end

  def favorites
    favorites = Favorite.where(user_id: current_user.id).pluck(:coordinate_id)
    @favorite_coordinates = Coordinate.order(created_at: :desc).find(favorites)
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
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
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
