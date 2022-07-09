class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @coordinate = Coordinate.find(params[:coordinate_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.coordinate_id = @coordinate.id
    if @comment.save
      # 通知作成
      @coordinate.create_notification_comment(current_user, @comment.id)
    else
      render "public/coordinates/show"
    end
  end

  def destroy
    @coordinate = Coordinate.find(params[:coordinate_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
