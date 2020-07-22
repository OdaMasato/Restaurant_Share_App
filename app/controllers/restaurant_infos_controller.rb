class RestaurantInfosController < ApplicationController

  require "api_helper"
  include ApiHelper

  def new
    # ぐるなびのレストラン検索APIへのURLを作成
    gnavi_url = 'https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid='

    # credentialsに登録しているアクセスキーを取得
    api_key = Rails.application.credentials.dig(:grunavi, :api_key)
    gnavi_url << api_key

    # 検索文字列とURLを連結
    word = params[:search]
    word ||= ""
    gnavi_url << "&name=" << word 

    # HTTPリクエスト及びレスポンス(json)を取得
    result = get_http_res_json(gnavi_url)
    @rests=result["rest"]
  end


  def create
    # パラメータから必要な情報を取得
    restaurant_info_id = params['id']

    # DB登録がない場合のみRestaurantInfoレコード追加
    if !(RestaurantInfo.exists?(restaurant_info_id: restaurant_info_id))

      # RestaurantInfo登録処理
      address = params['address']
      image_url_shop_image1 = params['image_url']['shop_image1']
      opentime = params['opentime']
      holiday = params['holiday']
      pr_short = params['pr_short']
  
      # インスタンス変数に代入
      restaurantInfo = RestaurantInfo.new()
      restaurantInfo.restaurant_info_id = restaurant_info_id
      restaurantInfo.address = address
      restaurantInfo.image_url_shop_image1 = image_url_shop_image1
      restaurantInfo.opentime = opentime
      restaurantInfoho.liday = holiday
  
      # 登録実行
      restaurantInfo.save!  
    end

    # ☆他コントローラーのアクション実行手段があっている気がしないので確認する
    redirect_to mark_restaurants_create_path(restaurant_info_id: restaurant_info_id)

  end
end
