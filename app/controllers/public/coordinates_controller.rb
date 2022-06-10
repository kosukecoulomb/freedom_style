class Public::CoordinatesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_current_user, only: [:edit, :update, :destroy]

  def index
    @coordinates = Coordinate.all.order(created_at: :desc)
  end

  def new
    @user = current_user
    @coordinate = Coordinate.new
    @outer_items = Item.where(user_id: @user.id, category: 0)
    @tops_items = Item.where(user_id: @user.id, category: 1)
    @bottoms_items = Item.where(user_id: @user.id, category: 2)
    @shoes_items = Item.where(user_id: @user.id, category: 3)
    @other_items = Item.where(user_id: @user.id, category: 4)
  end

  def create
    @coordinate = Coordinate.new(coordinate_params)
    if @coordinate.save
      redirect_to coordinate_path(@coordinate)
      flash[:notice] = "投稿に成功しました"
    else
      render :new
    end
  end

  def show
    @coordinate = Coordinate.find(params[:id])
    @comment = Comment.new
    @user = @coordinate.user
    @outer_item = Item.find_by(id: @coordinate.outer_id)
    @tops_item = Item.find_by(id: @coordinate.tops_id)
    @bottoms_item = Item.find_by(id: @coordinate.bottoms_id)
    @shoes_item = Item.find_by(id: @coordinate.shoes_id)
    @other1_item = Item.find_by(id: @coordinate.other1_id)
    @other2_item = Item.find_by(id: @coordinate.other2_id)
  end

  def edit
    @user = current_user
    @coordinate = Coordinate.find(params[:id])
    @outer_items = Item.where(user_id: @user.id, category: 0)
    @tops_items = Item.where(user_id: @user.id, category: 1)
    @bottoms_items = Item.where(user_id: @user.id, category: 2)
    @shoes_items = Item.where(user_id: @user.id, category: 3)
    @other_items = Item.where(user_id: @user.id, category: 4)
  end

  def update
    @coordinate = Coordinate.find(params[:id])
    if @coordinate.update(coordinate_params)
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
  end

  private

  def coordinate_params
    params.require(:coordinate).permit(:coordinate_image, :user_id, :title, :body, :dress_code, :season, :temperature, :outer_id, :tops_id, :bottoms_id, :shoes_id, :other1_id, :other2_id)
  end

  def ensure_current_user
    @coordinate = Coordinate.find(params[:id])
    if current_user.id != @coordinate.user_id
      flash[:notice]="権限がありません"
      redirect_to coordinates_path
    end
  end

end
