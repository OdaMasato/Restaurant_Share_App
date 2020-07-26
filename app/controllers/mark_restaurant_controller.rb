class MarkRestaurantController < ApplicationController
  def create
    # パラメータから必要な情報を取得
    rest_id = params['id']

    # DB登録がない場合のみRestaurantInfoレコード追加
    if !(Restaurant.exists?(rest_id: rest_id))

      # RestaurantInfo登録処理
      address = params['address']
      image_url = params['image_url']['shop_image1']
      opentime = params['opentime']
      holiday = params['holiday']
      pr_short = params['pr_short']
  
      # インスタンス変数に代入
      restaurant = Restaurant.new()
      restaurant.rest_id = rest_id
      restaurant.address = address
      restaurant.image_url = image_url
      restaurant.opentime = opentime
      restaurant.holiday = holiday
  
      # 登録実行
      restaurant.save!  
    end

    # ☆他コントローラーのアクション実行手段があっている気がしないので確認する
    # redirect_to mark_restaurants_create_path(restaurant_info_id: restaurant_info_id)
  end
end
