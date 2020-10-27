class MarkRestaurantsController < ApplicationController
  def index
    @is_disp_filter = params[:is_disp_filter].to_i
    @is_disp_filter = 0 if @is_disp_filter.nil?

    @google_map_api_key = Rails.application.credentials.dig(:google_map, :api_key)
    @restaurants = WentRestaurant.get_went_restaurant_info(current_user.id, current_user.id)
    @restaurants.push(MarkRestaurant.get_mark_restaurant_info_following_onry(current_user.id, ''))
    @restaurants.push(MarkRestaurant.get_mark_restaurant_info(current_user.id, current_user.id))
    @restaurants.flatten!

    # is_disp_filterに0以外の数値が入力されている場合、
    # is_disp_filterよりもscore_avgが小さいrestaurant情報を削除する
    if 0 < @is_disp_filter
      @restaurants.select!{|e| e.score_avg >= @is_disp_filter}
    end

    gon.restaurants = @restaurants.uniq

    restaurants_attr = []
    @restaurants.each do |restaurant|
      if 0 == restaurant.mark_restaurant_count
        restaurants_attr << '-'
      else
        restaurants_attr << restaurant.score_avg
      end
      
    end
    gon.restaurants_attr = restaurants_attr
  end

  def create
    restaurant = Restaurant.get_param_restaurant(params)

    # RestaurantTableに同一IDのレコードが存在しない場合、restaurantを登録する
    if !Restaurant.exists?(gurunavi_id: restaurant.gurunavi_id)
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

  def update
    # MarkRestaurantTableのレコード削除
    mark_restaurant = MarkRestaurant.find_by(gurunavi_id: params[:id], user_id: current_user.id)
    mark_restaurant.update!(score: params.require(:score))

    redirect_to restaurants_index_path
  end

  def destroy

    # MarkRestaurantTableのレコード削除
    mark_restaurant = MarkRestaurant.find_by(gurunavi_id: params[:id], user_id: current_user.id)
    mark_restaurant.destroy!

    redirect_to restaurants_index_path
  end
end
