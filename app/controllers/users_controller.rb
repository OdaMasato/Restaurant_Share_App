class UsersController < ApplicationController
  def show
    # ログイン中ユーザのuser情報を取得
    @user = User.get_user_info(current_user.id)
    @follows = Follow.get_follow_count(current_user.id)
    @followee  = Follow.get_followee_count(current_user.id)

    # ログイン中ユーザが登録しているmark_restaurantのrestaurant情報を取得
    @restaurants = MarkRestaurant.get_mark_restaurant_info(current_user.id)
    @restaurants = Kaminari.paginate_array(@restaurants).page(params[:page])

  end

  def index
    if !(params[:search].nil?)
      @users = User.where('account_name LIKE ?', "%#{params[:search]}%")
    else
      # nop
    end
  end
end
