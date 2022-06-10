class Public::FavoritesController < ApplicationController

  def create
    @coordinate = Coordinate.find(params[:coordinate_id])
    favorite = current_user.favorites.new(coordinate_id: @coordinate.id)
    favorite.save
  end

  def destroy
    @coordinate = Coordinate.find(params[:coordinate_id])
    favorite = current_user.favorites.find_by(coordinate_id: @coordinate.id)
    favorite.destroy
  end

end
