class Admin::CoordinatesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @coordinates = Coordinate.all
  end

  def show
    @coordinate = Coordinate.find(params[:id])
    @user = @coordinate.user
    @outer_item = Item.find_by(id: @coordinate.outer_id)
    @tops_item = Item.find_by(id: @coordinate.tops_id)
    @bottoms_item = Item.find_by(id: @coordinate.bottoms_id)
    @shoes_item = Item.find_by(id: @coordinate.shoes_id)
    @other1_item = Item.find_by(id: @coordinate.other1_id)
    @other2_item = Item.find_by(id: @coordinate.other2_id)
  end
  
  def destroy
    @coordinate = Coordinate.find(params[:id])
    @coordinate.destroy
    redirect_to admin_coordinates_path
    flash[:notice] = "投稿を削除しました"
  end
end
