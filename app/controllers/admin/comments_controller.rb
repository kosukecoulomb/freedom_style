class Admin::CommentsController < ApplicationController
  
  def destroy
    @coordinate = Coordinate.find(params[:coordinate_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
  
end
