class WentRestaurantsController < ApplicationController

  def create
    # RestaurantTableに同一IDのレコードが存在しない場合、restaurantを登録する
    if !(Restaurant.exists?(gurunavi_id: params[:gurunavi_id]))
      @restaurant = get_param_restaurant(params)
      @restaurant.save!
    else
      # nop
    end

    # WentRestaurantTableにレコード追加
    went_restaurant = WentRestaurant.new(user_id: current_user.id, gurunavi_id: params[:gurunavi_id])

    # ☆エラー処理するのが望ましい
    went_restaurant.save!
    redirect_to restaurants_index_path
  end

  def destroy
    # WentRestaurantTableのレコード削除
    went_restaurant = WentRestaurant.find_by(gurunavi_id: params[:id], user_id: current_user.id)
    went_restaurant.destroy!
    redirect_to restaurants_index_path
  end

end
