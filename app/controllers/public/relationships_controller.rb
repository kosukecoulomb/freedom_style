class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    following = current_user.relationships.build(follower_id: params[:user_id])
    if following.save

      # 通知作成
      @user.create_notification_follow(current_user)
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    following = current_user.relationships.find_by(follower_id: params[:user_id])
    following.destroy
  end
end
