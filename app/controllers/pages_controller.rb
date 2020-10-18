class PagesController < ApplicationController

  # 定数
  HOME_DISP_POPULAR_RESTAURANT_NUM = 4

  def home
    @restaurants = MarkRestaurant.get_mark_restaurant_info_top(HOME_DISP_POPULAR_RESTAURANT_NUM)
  end
end
