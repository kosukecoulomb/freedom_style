class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @search_params = item_search_params  
    @items = Item.search(@search_params).order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
    @user = @item.user
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path
    flash[:notice] = "アイテムを削除しました"
  end
  
  private
  
  def item_search_params
    params.fetch(:search, {}).permit(:item_name)
  end
end
