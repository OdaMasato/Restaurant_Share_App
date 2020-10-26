class UsersController < ApplicationController
  def index
    @users = if params[:search].nil?
              User.where.not(id: current_user)
            else
              User.where('account_name LIKE ?', "%#{params[:search]}%").where.not(id: current_user.id)
            end

    @users = Follow.get_follows_info(@users, current_user.id)
    @users = Kaminari.paginate_array(@users).page(params[:page])
  end

  def edit
    # nop
  end

  def show
    # 表示するユーザ情報を取得
    @user = User.new
    @user = if params[:id].nil?
              User.get_user_info(current_user.id, current_user.id)
            else
              User.get_user_info(params[:id], current_user.id)
            end

    # フォロー中のユーザ情報を取得
    @followings = Follow.get_follows_info(@user, current_user.id)
    @followings = Kaminari.paginate_array(@followings).page(params[:page])
    @followings.sort_by { |u| u.followers_count }.reverse

    # ログイン中ユーザが登録しているmark_restaurantのrestaurant情報を取得
    @mark_restaurants = MarkRestaurant.get_mark_restaurant_info(@user.id, current_user.id)
    @mark_restaurants = Kaminari.paginate_array(@mark_restaurants).page(params[:page])

    # ログイン中ユーザが登録しているwent_restaurantのrestaurant情報を取得
    @went_restaurants = WentRestaurant.get_went_restaurant_info(@user.id, current_user.id)
    @went_restaurants = Kaminari.paginate_array(@went_restaurants).page(params[:page])

    @disp = params[:disp]

  end
end
