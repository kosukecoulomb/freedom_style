class Public::CoordinatesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_current_user, only: [:edit, :update, :destroy]

  def index
    # キーワード検索用
    @search_params = coordinate_search_params
    @coordinates = Coordinate.search(@search_params).order(created_at: :desc)
  end

  # フォロワーと自分のコーデ
  def timeline
    @coordinates = Coordinate.includes(:user).where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc)
    @following_coordinates = Coordinate.includes(:user).where(user_id: [*current_user.following_ids]).order(created_at: :desc)
    # フォロワーがなくタイムラインが空の場合は似たユーザー、さらになければ通常のユーザーを表示する
    @similar_users = User.similar(current_user)
    @users = User.all.limit(4).where.not(id: current_user.id)
  end

  def new
    @user = current_user
    @coordinate = Coordinate.new
    # タグ検索用
    @tag_list = Tag.popularity(30)
  end

  def create
    @coordinate = Coordinate.new(coordinate_params)
    @user = current_user
    # タグ検索用
    @tag_list = Tag.popularity(30)
    tag_list = params[:coordinate][:tag_name].split(nil)
    if @coordinate.save
      @coordinate.save_tag(tag_list) # タグ検索用
      redirect_to coordinate_path(@coordinate)
      flash[:notice] = "投稿に成功しました"
    else
      render :new
    end
  end

  def show
    @coordinate = Coordinate.find(params[:id])
    @comment = Comment.new
    # 紐付けられたアイテムを探して持ってくる
    @outer_item = Item.find_by(id: @coordinate.outer_id)
    @tops_item = Item.find_by(id: @coordinate.tops_id)
    @bottoms_item = Item.find_by(id: @coordinate.bottoms_id)
    @shoes_item = Item.find_by(id: @coordinate.shoes_id)
    @other1_item = Item.find_by(id: @coordinate.other1_id)
    @other2_item = Item.find_by(id: @coordinate.other2_id)
    # 似たようなコーデを表示
    @similar_coordinates = Coordinate.latest(4).where(dress_code: @coordinate.dress_code, season: @coordinate.season).
      joins(:user).merge(User.where(gender: @coordinate.user.gender)).
      where.not(id: @coordinate.id)
  end

  def edit
    @user = current_user
    @coordinate = Coordinate.find(params[:id])
    # タグ検索用
    @tag_list = Tag.popularity(30)
    @current_tags = @coordinate.tags.pluck(:tag_name)
  end

  def update
    @coordinate = Coordinate.find(params[:id])
    @user = current_user
    # タグ検索用
    @tag_list = Tag.popularity(30)
    @current_tags = @coordinate.tags.pluck(:tag_name)
    tag_list = params[:coordinate][:tag_name].split(nil)
    if @coordinate.update(coordinate_params)
      @coordinate.save_tag(tag_list)
      redirect_to coordinate_path(@coordinate)
      flash[:notice] = "コーディネートの更新に成功しました"
    else
      render :edit
    end
  end

  def destroy
    @coordinate = Coordinate.find(params[:id])
    @coordinate.destroy
    redirect_to my_page_path
    flash[:notice] = "コーディネートを削除しました"
  end

  # タグ検索結果ページ
  def tag_search
    @tag_list = Tag.popularity(30)
    @tag = Tag.find(params[:tag_id])
  end

  private

  def coordinate_params
    params.require(:coordinate).permit(:coordinate_image, :user_id, :title, :body, :dress_code, :season, :temperature, :outer_id, :tops_id, :bottoms_id, :shoes_id, :other1_id, :other2_id)
  end

  def ensure_current_user
    @coordinate = Coordinate.find(params[:id])
    if current_user.id != @coordinate.user_id
      flash[:notice] = "権限がありません"
      redirect_to coordinates_path
    end
  end

  def coordinate_search_params
    params.fetch(:search, {}).permit(:dress_code, :season, :temperature, :keyword, :gender, :generation, :body_shape, :tall_from, :tall_to)
    # fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
  end
end
