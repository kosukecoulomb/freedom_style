class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @coordinate = Coordinate.find(params[:coordinate_id])
    favorite = current_user.favorites.new(coordinate_id: @coordinate.id)
    favorite.save

    #通知作成
    coordinate.create_notification_favorite!(current_user)

  end

  def destroy
    @coordinate = Coordinate.find(params[:coordinate_id])
    favorite = current_user.favorites.find_by(coordinate_id: @coordinate.id)
    favorite.destroy
  end

end
