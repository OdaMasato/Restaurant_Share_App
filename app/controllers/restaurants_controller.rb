class RestaurantsController < ApplicationController
  require 'Gurunavi'

  def index
    # ぐるなびレストラン検索APIのフリワード検索URLを取得
    url = Gurunavi.get_freeword_search_url(params[:search])

    # フリワード検索を行い、ハッシュ化したレスポンス(json)を取得
    results = Gurunavi.get_http_res_json(url)

    if !(results.nil?)
      # 取得成功の場合
      # レスポンスからRestaurant情報を取得
      @restaurants = Restaurant.get_gurunavi_params_restaurants_arg(results)
      @total_hit_count = results[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_HIT_COUNT]
    else
      # 取得失敗の場合
      @total_hit_count = Gurunavi::GURUNAVI_RESTAURANT_SEARCH_HIT_COUNT_ZERO
    end
  end

  def show
    @restaurant = Restaurant.get_param_restaurant(params)
  end
end