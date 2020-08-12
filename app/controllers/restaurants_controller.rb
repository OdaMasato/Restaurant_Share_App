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

    # HTTPリクエスト及びレスポンス(json)を取得
    results = Gnavi.get_http_res_json(gnavi_url)
    results = results['rest']

    # レスポンスをRestaurantインスタンス配列にセットする
    @restaurants = []
    results.each do |result|
      restaurant = Restaurant.new
      restaurant.gurunavi_id = result['id']
      restaurant.category = result['category']
      restaurant.name = result['name']
      restaurant.address = result['address']
      restaurant.image_url = result['image_url']['shop_image1']
      restaurant.opentime = result['opentime']
      restaurant.holiday = result['holiday']
      restaurant.pr_short = result['pr_short']

      # MarkRestaurantテーブルの登録有無をrestaurantインスタンスに格納する
      if MarkRestaurant.exists?(gurunavi_id: restaurant.gurunavi_id)
        restaurant.mark_restaurant_currentuser_reg_exist = true
      else
        restaurant.mark_restaurant_currentuser_reg_exist = false     
      end
      @restaurants << restaurant
    end
  end
end