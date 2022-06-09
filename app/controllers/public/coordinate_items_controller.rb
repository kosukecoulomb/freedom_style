class Public::CoordinateItemsController < ApplicationController
  
  def new
    @coordinate_item = CoordinateItem.new
    @user = current_user
    @coordinate = Coordinate.order(created_at: :desc).find_by(user_id: current_user.id)
    @outer_items = Item.where(user_id: @user.id, category: 0)
    @tops_items = Item.where(user_id: @user.id, category: 1)
    @bottoms_items = Item.where(user_id: @user.id, category: 2)
    @shoes_items = Item.where(user_id: @user.id, category: 3)
    @other_items = Item.where(user_id: @user.id, category: 4)
  end
  
  def create
    @coordinate = Coordinate.order(created_at: :desc).find_by(user_id: current_user.id)
    @coordinate_item = CoordinateItem.new(coordinate_item_params)
    if @coordinate_item.save
      redirect_to coordinate_path(@coordinate)
      flash[:notice] = "投稿に成功しました"
    else
      render :new
    end
  end

  def edit
  end
  
  def coordinate_item_params
    params.require(:coordinate_item).permit( :coordinate_id, :outer_item_id, :tops_item_id, :bottoms_item_id, :shoes_item_id, :other_item1_id, :other_item2_id)
  end
end
