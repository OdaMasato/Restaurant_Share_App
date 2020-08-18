class WentRestaurantsController < ApplicationController
    # コントローラごとに記述しないようにしたい
    before_action :authenticate_user!

    def create
      # パラメータからrestaurant情報を取得
      restaurant = Restaurant.get_param_restaurant(params)
  
      # RestaurantTableに同一IDのレコードが存在しない場合、restaurantを登録する
      if !(Restaurant.exists?(gurunavi_id: restaurant.gurunavi_id))
        restaurant.save!
      else
        # nop
      end
  
      # WentRestaurantTableにレコード追加
      went_restaurant = WentRestaurant.new
      went_restaurant.user_id = current_user.id
      went_restaurant.gurunavi_id = restaurant.gurunavi_id 
      # ☆エラー処理するのが望ましい
      went_restaurant.save!
      redirect_to restaurants_index_path
    end
  
    def destroy
      # パラメータからrestaurant情報を取得
      restaurant = Restaurant.new
      restaurant = Restaurant.get_param_restaurant(params)
  
      # WentRestaurantTableのレコード削除
      went_restaurant = WentRestaurant.find_by(gurunavi_id: restaurant.gurunavi_id, user_id: current_user.id)
      went_restaurant.destroy!
      redirect_to restaurants_index_path
    end
end
