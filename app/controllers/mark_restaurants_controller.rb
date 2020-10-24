class MarkRestaurantsController < ApplicationController
  def index
    @google_map_api_key = Rails.application.credentials.dig(:google_map, :api_key)
    @restaurants = MarkRestaurant.get_mark_restaurant_info(current_user.id, current_user.id)
    gon.restaurants = @restaurants

    restaurants_attr = []
    @restaurants.each do |restaurant|
      restaurants_attr << restaurant.score_avg
    end
    gon.restaurants_attr = restaurants_attr
  end

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

  def update()
    # パラメータからrestaurant情報を取得
    restaurant = Restaurant.new
    restaurant = Restaurant.get_param_restaurant(params)

    # MarkRestaurantTableのレコード削除
    mark_restaurant = MarkRestaurant.find_by(gurunavi_id: restaurant.gurunavi_id, user_id: current_user.id)
    mark_restaurant.update!(score: params.require(:score))

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

end
