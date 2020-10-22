class MarkRestaurantsController < ApplicationController
  def create
    restaurant = Restaurant.get_param_restaurant(params)

    # RestaurantTableに登録する
    restaurant.save!
    
    # MarkRestaurantTableにレコードを登録
    mark_restaurant = MarkRestaurant.new
    mark_restaurant.user_id = current_user.id
    mark_restaurant.gurunavi_id = restaurant.gurunavi_id
    mark_restaurant.score = params.require(:score)

    # ☆エラー処理するのが望ましい
    mark_restaurant.save!

    redirect_to restaurants_path
  end

  def update()
    # パラメータからrestaurant情報を取得
    restaurant = Restaurant.new
    restaurant = Restaurant.get_param_restaurant(params)

    # MarkRestaurantTableのレコード削除
    mark_restaurant = MarkRestaurant.find_by(gurunavi_id: restaurant.gurunavi_id, user_id: current_user.id)
    mark_restaurant.update!(score: params.require(:score))

    redirect_to restaurants_path
  end
  
  def destroy
    # パラメータからrestaurant情報を取得
    restaurant = Restaurant.new
    restaurant = Restaurant.get_param_restaurant(params)

    # MarkRestaurantTableのレコード削除
    mark_restaurant = MarkRestaurant.find_by(gurunavi_id: restaurant.gurunavi_id, user_id: current_user.id)
    mark_restaurant.destroy!

    redirect_to restaurants_path
  end

end
