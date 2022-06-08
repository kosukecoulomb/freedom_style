class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def my_page
    @user = current_user
    more_short = current_user.tall.to_i - 4
    more_tall = current_user.tall.to_i + 5
    #ユーザー本人でない人の投稿で、ユーザーのジェンダーが同じ身長-4~+5cmの投稿を絞り込んで新着順に４件表示
    @similar_talls = User.where(tall: more_short..more_tall, gender: current_user.gender).where.not(id: current_user.id)
    @similar_talls.each do |user|
      @coordinates = user.coordinates.all.limit(4).order(created_at: :desc)
    end
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

end
