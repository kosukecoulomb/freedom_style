class Public::ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
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
      render new
    end
  end

  def index
    @user = current_user
    @outer_items = Item.where(user_id: @user.id, category: 0)
    @tops_items = Item.where(user_id: @user.id, category: 1)
    @bottoms_items = Item.where(user_id: @user.id, category: 2)
    @shoes_items = Item.where(user_id: @user.id, category: 3)
    @other_items = Item.where(user_id: @user.id, category: 4)
  end

  private

  def item_params
    params.require(:item).permit(:item_image, :user_id, :item_name, :brand_name, :category, :size, :color, :price)
  end
  
  def ensure_current_user
    @item = Item.find(params[:id])
    if current_user.id != @item.user_id
      flash[:notice]="権限がありません"
      redirect_to items_path
    end
  end
end