class RestaurantsController < ApplicationController
  require 'Gnavi'

  def index
    # ぐるなびのレストラン検索APIへのURLを作成
    gnavi_url = 'https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid='

    # credentialsに登録しているアクセスキーを取得
    api_key = Rails.application.credentials.dig(:grunavi, :api_key)
    gnavi_url << api_key

    # 検索文字列とURLを連結
    word = params[:search]
    word ||= ''
    gnavi_url << '&name=' << word

    # HTTPリクエスト及びレスポンス(json)を取得し、Restaurant配列にセットする
    results = Gnavi.get_http_res_json(gnavi_url)
    @restaurants = Restaurant.get_gnavi_params_restaurants_arg(results)
    @total_hit_count = results['total_hit_count']
  end

  def show
    @restaurant = Restaurant.get_param_restaurant(params)
  end
end