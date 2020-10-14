class UsersController < ApplicationController

  def show
    # 表示するユーザ情報を取得
    @user = User.new()
    if params[:user].nil?
      @user = User.get_user_info(current_user.id, current_user.id)
    else
      @user = User.get_user_info(params[:user][:id], current_user.id)
    end

    # フォロー中のユーザ情報を取得
    @followings = Follow.get_follows_info(@user, Follow::GET_FOLLOWS_INFO_TYPE_FOLLOWINGS, current_user.id)
    @followings = Kaminari.paginate_array(@followings).page(params[:page])

    # フォローされているユーザ情報を取得
    @followers  = Follow.get_follows_info(@user, Follow::GET_FOLLOWS_INFO_TYPE_FOLLOWERS, current_user.id)
    @followers = Kaminari.paginate_array(@followers).page(params[:page])

    # ログイン中ユーザが登録しているmark_restaurantのrestaurant情報を取得
    @mark_restaurants = MarkRestaurant.get_mark_restaurant_info(@user.id, current_user.id)
    @mark_restaurants = Kaminari.paginate_array(@mark_restaurants).page(params[:page])

    # ログイン中ユーザが登録しているwent_restaurantのrestaurant情報を取得
    @went_restaurants = WentRestaurant.get_went_restaurant_info(@user.id, current_user.id)
    @went_restaurants = Kaminari.paginate_array(@went_restaurants).page(params[:page])

    @disp = params[:disp]
  end

  def index
    if params[:search].nil?
      @users = User.where.not(id: current_user)
    else
      @users = User.where('account_name LIKE ?', "%#{params[:search]}%").where.not(id: current_user.id)
    end
    
    @users = Follow.get_follows_info(@users, Follow::GET_FOLLOWS_INFO_TYPE_FOLLOWINGS, current_user.id)
    @users = Kaminari.paginate_array(@users).page(params[:page])
  end

  def edit
    # nop
  end
end
