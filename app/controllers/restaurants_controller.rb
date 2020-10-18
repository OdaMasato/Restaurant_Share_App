class RestaurantsController < ApplicationController
  require 'Gurunavi'

  def index
    # ぐるなびレストラン検索APIのフリワード検索URLを取得
    url = Gurunavi.get_freeword_search_url(params[:search],Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_REQ_HIT_COUNT_DEFAULT)

    # フリワード検索を行い、ハッシュ化したレスポンス(json)を取得
    results = Gurunavi.get_http_res_json(url)

    if !(results.nil?)
      # 取得成功の場合
      # レスポンスからRestaurant情報を取得
      @restaurants = Restaurant.get_gurunavi_params_restaurants_arg(results)
      @restaurants = Restaurant.set_accessor(@restaurants, current_user.id)
      @restaurants = Kaminari.paginate_array(@restaurants).page(params[:page])
    else
      # 取得失敗の場合
      # nop
    end
  end

  def show
    @restaurant = Restaurant.get_param_restaurant(params)
    @restaurant = Restaurant.set_accessor(@restaurant, current_user.id)
  end
end