class UsersController < ApplicationController
  def show

    # ログイン中ユーザのuser情報を取得
    @user = User.find_by(id: current_user.id)
    @follows = Follow.where(user_id: current_user.id).count 
    @followee  = Follow.where(follow_id: current_user.id).count

    # ログイン中ユーザが登録しているmark_restaurantのrestaurant情報を取得
    mark_restaurants = MarkRestaurant.where(user_id: current_user.id)
    @restaurants = []

    # mark_restaurantのrestaurant情報を取得し配列に格納
    mark_restaurants.each do |mark_restaurant|
      restaurant = Restaurant.new
      restaurant = mark_restaurant.restaurant
      restaurant.mark_restaurant_user_reg = true
      Restaurant.set_went_restaurant_user_reg(restaurant)
      @restaurants << restaurant
    end
  end

  def index
    if !(params[:search].nil?)
      @users = User.where('account_name LIKE ?', "%#{params[:search]}%")
    else
      # nop
    end
  end
end
