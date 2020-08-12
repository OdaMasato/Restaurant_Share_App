class MarkRestaurantsController < ApplicationController
  # コントローラごとに記述しないようにしたい
  before_action :authenticate_user!

  def create
    # RestaurantTableにレコード追加
    gurunavi_id = params[:gurunavi_id]
    if !(Restaurant.exists?(gurunavi_id: gurunavi_id))
      restaurant = Restaurant.new
      restaurant.gurunavi_id = gurunavi_id
      restaurant.category = params[:category]
      restaurant.name = params[:name]
      restaurant.address = params[:address]
      restaurant.image_url = params[:image_url]
      restaurant.opentime = params[:opentime]
      restaurant.holiday = params[:holiday]
      restaurant.pr_short = params[:pr_short]
      restaurant.save!
    end

    # MarkRestaurantTableにレコード追加
    mark_restaurant = MarkRestaurant.new
    mark_restaurant.user_id = current_user.id
    mark_restaurant.gurunavi_id = gurunavi_id 
    # ☆エラー処理するのが望ましい
    mark_restaurant.save!

    redirect_to restaurants_index_path
  end

  def destroy
    # MarkRestaurantTableのレコード削除
    mark_restaurant = MarkRestaurant.find(gurunavi_id: restaurant.gurunavi_id, user_id: current_user.id)
    mark_restaurant.destroy!
  end
end
