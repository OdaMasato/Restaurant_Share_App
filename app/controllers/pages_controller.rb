class PagesController < ApplicationController
  def home
    @restaurants = MarkRestaurant.get_mark_restaurant_info_top_10()
  end
end
