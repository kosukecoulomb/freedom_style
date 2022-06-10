class Public::CoordinatesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_current_user, only: [:edit, :update, :destroy]

  def index
    @coordinates = Coordinate.all.order(created_at: :desc)
  end

  def new
    @user = current_user
    @coordinate = Coordinate.new
  end

  def create
    @coordinate = Coordinate.new(coordinate_params)
    if @coordinate.save
      redirect_to new_coordinate_item_path
      flash[:notice] = "投稿に成功しました"
    else
      render :new
    end
  end

  def show
    @coordinate = Coordinate.find(params[:id])
    @comment = Comment.new
    
    #コーディネートに紐付けられたアイテムの
    @user = @coordinate.user
    @coordinate_item = CoordinateItem.find_by(coordinate_id: @coordinate.id)
    @outer_item = Item.find_by(id: @coordinate_item.outer_item_id)
    @tops_item = Item.find_by(id: @coordinate_item.tops_item_id)
    @bottoms_item = Item.find_by(id: @coordinate_item.bottoms_item_id)
    @shoes_item = Item.find_by(id: @coordinate_item.shoes_item_id)
    @other_item1 = Item.find_by(id: @coordinate_item.other_item1_id)
    @other_item2 = Item.find_by(id: @coordinate_item.other_item2_id)
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
    params.require(:coordinate).permit(:coordinate_image, :user_id, :coordinate_item_id, :title, :body, :dress_code, :season, :temperature, :total_price)
  end

  def ensure_current_user
    @coordinate = Coordinate.find(params[:id])
    if current_user.id != @coordinate.user_id
      flash[:notice]="権限がありません"
      redirect_to coordinates_path
    end
  end

end
