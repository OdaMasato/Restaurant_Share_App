class MarkRestaurantsController < ApplicationController

  def create
    markRestaurants = MarkRestaurant.new()
    
    markRestaurants.user_id = current_user.id
    markRestaurants.restaurant_info_id = params[:restaurant_info_id]
    markRestaurants.save!
    redirect_to restaurant_infos_new_path
  end

  def destroy
  end
end
