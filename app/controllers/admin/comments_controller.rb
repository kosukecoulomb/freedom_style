class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @coordinate = Coordinate.find(params[:coordinate_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_coordinate_path(@coordinate)
    flash[:notice] = "コメントを削除しました"
  end
end
