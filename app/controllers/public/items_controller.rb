class Public::ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_current_user, only: [:edit, :update, :destroy]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path
      flash[:notice] = "投稿に成功しました"
    else
      render :new
    end
  end

  def index
    @search_params = item_search_params
    @items = Item.search(@search_params).order(created_at: :desc)
  end

  def collection
    @user = User.find(params[:id])
    @outer_items = Item.where(user_id: @user.id, category: 0)
    @tops_items = Item.where(user_id: @user.id, category: 1)
    @bottoms_items = Item.where(user_id: @user.id, category: 2)
    @shoes_items = Item.where(user_id: @user.id, category: 3)
    @other_items = Item.where(user_id: @user.id, category: 4)
  end

  def show
    @item = Item.find(params[:id])
    # @itemを使った投稿を表示
    @coordinates = Coordinate.where(outer_id: @item.id).or(Coordinate.where(tops_id: @item.id)).
      or(Coordinate.where(bottoms_id: @item.id)).
      or(Coordinate.where(shoes_id: @item.id)).
      or(Coordinate.where(other1_id: @item.id)).
      or(Coordinate.where(other2_id: @item.id))
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
      flash[:notice] = "編集に成功しました"
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:item_image, :user_id, :item_name, :brand_name, :category, :size, :color, :price)
  end

  def ensure_current_user
    @item = Item.find(params[:id])
    if current_user.id != @item.user_id
      flash[:notice] = "権限がありません"
      redirect_to items_path
    end
  end

  def item_search_params
    params.fetch(:search, {}).permit(:category, :keyword, :price_from, :price_to)
  end
end
