class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
   before_action :ensure_guest_user, only: [:edit]

  def my_page
    @user = current_user
    @coordinates = Coordinate.where(user_id: @user.id)
    
    more_short = current_user.tall.to_i - 4
    more_tall = current_user.tall.to_i + 5
    #ユーザー本人でない人の投稿で、ユーザーのジェンダーが同じ身長-4~+5cmの投稿を絞り込んで新着順に４件表示
    @similar_talls = User.where(tall: more_short..more_tall, gender: current_user.gender).where.not(id: current_user.id)
    @similar_talls.each do |user|
      @similar_coordinates = user.coordinates.all.limit(6).order(created_at: :desc)
    end

    #いいねしたアイテム表示
    favorites = Favorite.where(user_id: @user.id).pluck(:coordinate_id)
    @favorite_coordinates = Coordinate.limit(6).order(created_at: :desc).find(favorites)
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
      redirect_to my_page_path
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

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction, :gender, :generation, :tall, :body_shape, :foot_size)
  end
  
  #ゲストユーザー機能
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  

end
