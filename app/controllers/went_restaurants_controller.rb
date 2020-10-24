class WentRestaurantsController < ApplicationController
  before_action :get_param_restaurant, only: [:create, :destroy]

  def create
    # RestaurantTableに同一IDのレコードが存在しない場合、restaurantを登録する
    if !(Restaurant.exists?(gurunavi_id: @restaurant.gurunavi_id))
      @restaurant.save!
    else
      # nop
    end

    # WentRestaurantTableにレコード追加
    went_restaurant = WentRestaurant.new
    went_restaurant.user_id = current_user.id
    went_restaurant.gurunavi_id = @restaurant.gurunavi_id 
    # ☆エラー処理するのが望ましい
    went_restaurant.save!
    redirect_to restaurants_index_path
  end

  def destroy

    # WentRestaurantTableのレコード削除
    went_restaurant = WentRestaurant.find_by(gurunavi_id: @restaurant.gurunavi_id, user_id: current_user.id)
    went_restaurant.destroy!
    redirect_to restaurants_index_path
  end
  
  private
  def get_param_restaurant
    @restaurant = Restaurant.get_param_restaurant(params)
  end
end
