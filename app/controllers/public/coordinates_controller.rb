class Public::CoordinatesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_current_user, only: [:edit, :update, :destroy]

  def index
    #キーワード検索用
    @search_params = coordinate_search_params  #検索結果の画面で、フォームに検索した値を表示するために、paramsの値をビューで使えるようにする
    @coordinates = Coordinate.search(@search_params).order(created_at: :desc)  #searchを呼び出し、引数としてparamsを渡している。
  end


  #フォロワーと自分のコーデ
  def timeline
    @coordinates = Coordinate.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc)
    more_short = current_user.tall.to_i - 4
    more_tall = current_user.tall.to_i + 5
    @similar_users = User.where(tall: more_short..more_tall, gender: current_user.gender).where.not(id: current_user.id)
    @users = User.all.limit(10).where.not(id: current_user.id)
  end

  def new
    @user = current_user
    @coordinate = Coordinate.new

    #タグ検索用
    @tag_list = Tag.limit(10).find(TagMap.group(:tag_id).order('count(coordinate_id) desc').pluck(:tag_id))

    #登録アイテムと紐付けるための変数
    @outer_items = Item.where(user_id: @user.id, category: 0)
    @tops_items = Item.where(user_id: @user.id, category: 1)
    @bottoms_items = Item.where(user_id: @user.id, category: 2)
    @shoes_items = Item.where(user_id: @user.id, category: 3)
    @other_items = Item.where(user_id: @user.id, category: 4)
  end


  def create
    #タグ検索用
    tag_list = params[:coordinate][:tag_name].split(nil)

    @coordinate = Coordinate.new(coordinate_params)
    @user = current_user

    #タグ検索用
     @tag_list = Tag.limit(10).find(TagMap.group(:tag_id).order('count(coordinate_id) desc').pluck(:tag_id))

    #登録アイテムと紐付けるための変数
    @outer_items = Item.where(user_id: @user.id, category: 0)
    @tops_items = Item.where(user_id: @user.id, category: 1)
    @bottoms_items = Item.where(user_id: @user.id, category: 2)
    @shoes_items = Item.where(user_id: @user.id, category: 3)
    @other_items = Item.where(user_id: @user.id, category: 4)

    if @coordinate.save
      @coordinate.save_tag(tag_list) #タグ検索用
      redirect_to coordinate_path(@coordinate)
      flash[:notice] = "投稿に成功しました"
    else
      render :new
    end
  end


  def show
    @coordinate = Coordinate.find(params[:id])
    @comment = Comment.new
    @user = @coordinate.user

    #タグ検索用
    @coordinate_tags = @coordinate.tags.all
    @tag_list = Tag.all

    #紐付けられたアイテムを探して持ってくる
    @outer_item = Item.find_by(id: @coordinate.outer_id)
    @tops_item = Item.find_by(id: @coordinate.tops_id)
    @bottoms_item = Item.find_by(id: @coordinate.bottoms_id)
    @shoes_item = Item.find_by(id: @coordinate.shoes_id)
    @other1_item = Item.find_by(id: @coordinate.other1_id)
    @other2_item = Item.find_by(id: @coordinate.other2_id)
    
    #似たようなコーデを表示
    @similar_coordinates = Coordinate.where(dress_code: @coordinate.dress_code, season: @coordinate.season).limit(4).order(created_at: :desc).where.not(id: @coordinate.id)
  end


  def edit
    @user = current_user
    @coordinate = Coordinate.find(params[:id])

    #new同様
    @outer_items = Item.where(user_id: @user.id, category: 0)
    @tops_items = Item.where(user_id: @user.id, category: 1)
    @bottoms_items = Item.where(user_id: @user.id, category: 2)
    @shoes_items = Item.where(user_id: @user.id, category: 3)
    @other_items = Item.where(user_id: @user.id, category: 4)
  end


  def update
    #タグ検索用
    tag_list = params[:coordinate][:tag_name].split(nil)

    @coordinate = Coordinate.find(params[:id])
    @user = current_user

    #new同様
    @outer_items = Item.where(user_id: @user.id, category: 0)
    @tops_items = Item.where(user_id: @user.id, category: 1)
    @bottoms_items = Item.where(user_id: @user.id, category: 2)
    @shoes_items = Item.where(user_id: @user.id, category: 3)
    @other_items = Item.where(user_id: @user.id, category: 4)

    if @coordinate.update(coordinate_params)
      @coordinate.save_tag(tag_list) #タグ検索用
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
    flash[:notice] = "コーディネートを削除しました"
  end

  #タグ検索結果ページ
  def search
    @tag_list = Tag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    @coordinates = @tag.coordinates.all           #クリックしたタグに紐付けられた投稿を全て表示
  end



  private

  def coordinate_params
    params.require(:coordinate).permit(:coordinate_image, :user_id, :title, :body, :dress_code, :season, :temperature, :outer_id, :tops_id, :bottoms_id, :shoes_id, :other1_id, :other2_id, tags_attributes: [:tag_name])
  end

  def ensure_current_user
    @coordinate = Coordinate.find(params[:id])
    if current_user.id != @coordinate.user_id
      flash[:notice]="権限がありません"
      redirect_to coordinates_path
    end
  end

  def coordinate_search_params
    params.fetch(:search, {}).permit(:dress_code, :season, :temperature, :title, :gender, :generation, :body_shape, :tall_from, :tall_to)
    #fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
    #ここでの:searchには、フォームから送られてくるparamsの値が入っている
  end

end
