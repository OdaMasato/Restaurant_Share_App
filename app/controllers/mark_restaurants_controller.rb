class MarkRestaurantsController < ApplicationController
  # コントローラごとに記述しないようにしたい
  before_action :authenticate_user!

  def create
    restaurant = Restaurant.get_param_restaurant(params)

    # RestaurantTableに同一IDのレコードが存在しない場合、restaurantを登録する
    if !(Restaurant.exists?(gurunavi_id: restaurant.gurunavi_id))
      restaurant.save!
    else
      # nop
    end
    
    # MarkRestaurantTableにレコードを登録
    mark_restaurant = MarkRestaurant.new
    mark_restaurant.user_id = current_user.id
    mark_restaurant.gurunavi_id = restaurant.gurunavi_id
    mark_restaurant.score = params.require(:score)

    # ☆エラー処理するのが望ましい
    mark_restaurant.save!

    redirect_to restaurants_index_path
  end

  def destroy
    # パラメータからrestaurant情報を取得
    restaurant = Restaurant.new
    restaurant = Restaurant.get_param_restaurant(params)

    # MarkRestaurantTableのレコード削除
    mark_restaurant = MarkRestaurant.find_by(gurunavi_id: restaurant.gurunavi_id, user_id: current_user.id)
    mark_restaurant.destroy!

    redirect_to restaurants_index_path
  end

  def update()
    # パラメータからrestaurant情報を取得
    restaurant = Restaurant.new
    restaurant = Restaurant.get_param_restaurant(params)

    # MarkRestaurantTableのレコード削除
    mark_restaurant = MarkRestaurant.find_by(gurunavi_id: restaurant.gurunavi_id, user_id: current_user.id)
    mark_restaurant.update!(score: params.require(:score))

    redirect_to restaurants_index_path
  end
end