class Chat < ApplicationRecord

  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy
  
  #通知機能
  def create_notification_chat(current_user)
    visited_id = find_visited_user(current_user).id
    
    # 投稿者に通知を送る
    notification = current_user.active_notifications.new(
      chat_id: self.id,
      visited_id: visited_id,
      action: 'chat'
    )
    notification.save
  end
  
  # チャットしている相手を取得する
  def find_visited_user(current_user)
    UserRoom.where(room_id: self.room_id).where.not(user_id: current_user.id).take.user
  end
end
