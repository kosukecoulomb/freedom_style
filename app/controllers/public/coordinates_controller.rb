class Public::CoordinatesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @coordinates = Coordinate.all.order(Arel.sql(" created_at DESC "))
  end

  def new
    @coordinate = Coordinate.new
  end

  def create
    @coordinate = Coordinate.new(coordinate_params)
    if @coordinate.save
      redirect_to coordinate_path(@coordinate)
      flash[:notice] = "投稿に成功しました"
    else
      render :new
    end
  end

  def show
    @coordinate = Coordinate.find(params[:id])
    @user = @coordinate.user
  end

  def edit
    @coordinate = Coordinate.find(params[:id])
  end

  def update
    @coordinate = Coordinate.find(params[:id])
    if @coordinate.update(coordinate_params)
      redirect_to coordinate_path(@coordinate)
      flash[:notice] = "コーディネートの更新に成功しました"
    else
      render :edit
    end
  end
  
  def destroy
    @coordinate = Coordinate.find(params[:id])
    @coordinate.destroy
    redirect_to my_page_path
  end

  private

  def coordinate_params
    params.require(:coordinate).permit(:coordinate_image, :user_id, :coordinate_item_id, :title, :body, :dress_code, :season, :temperature, :total_price)
  end

end
