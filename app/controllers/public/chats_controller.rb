class Public::ChatsController < ApplicationController
  before_action :authenticate_user!

  def show
    chat = Chat.find(params[:id])
    @user = chat.find_visited_user(current_user)
    unless current_user.is_followed_by?(@user) && current_user.is_following?(@user)
      redirect_to user_path(@user)
      flash[:notice] = "相互フォローしていなければチャットはできません"
    else
      rooms = current_user.user_rooms.pluck(:room_id)
      user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

      unless user_rooms.nil?
        @room = user_rooms.room
      else
        @room = Room.new
        @room.save
        UserRoom.create(user_id: current_user.id, room_id: @room.id)
        UserRoom.create(user_id: @user.id, room_id: @room.id)
      end

      @chats = @room.chats
      @chat = Chat.new(room_id: @room.id)
    end
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    @chat.create_notification_chat(current_user)
    @chats = @chat.room.chats
      #redirect_to request.referer
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

end
