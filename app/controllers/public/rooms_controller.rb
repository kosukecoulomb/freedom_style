class Public::RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create
    @room.save
    @user = User.find(params[:user_id])
    UserRoom.create(user_id: current_user.id, room_id: @room.id)
    UserRoom.create(user_id: @user.id, room_id: @room.id)
    redirect_to user_room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    @user = chat.find_visited_user(current_user)
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end
end


