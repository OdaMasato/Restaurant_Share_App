class Restaurant < ApplicationRecord
  # ☆mark_restaurant_user_reg名前変えたい
  attr_accessor :mark_restaurant_user_reg

  # has_many :mark_restaurant

  # [概　要] ぐるなびのレストラン検索APIのレスポンスパラメータからrestaurant配列を取得
  # [引　数] ぐるなび レストラン検索APIレスポンスパラメータ(json)
  # [戻り値] 正常完了:restaurant[] / 正常完了以外:nil
  # [説　明] 引数のパラメータより飲食店情報を取得し、restaurant配列として返す
  def self.get_gnavi_params_restaurants_arg(params)
    restaurants = []
    params = params['rest']

    params.each do |param|
      restaurant = Restaurant.new
      restaurant.gurunavi_id = param['id']
      restaurant.category = param['category']
      restaurant.name = param['name']
      restaurant.address = param['address']
      restaurant.image_url = param['image_url']['shop_image1']
      restaurant.opentime = param['opentime']
      restaurant.holiday = param['holiday']
      restaurant.pr_short = param['pr_short']
      set_mark_restaurant_user_reg(restaurant)
      restaurants << restaurant
    end
    restaurants
  end

  # [概　要] Restaurantオブジェクトのハッシュパラメータからrestaurantインスタンスを取得
  # [引　数] Restaurantオブジェクトのハッシュパラメータ
  # [戻り値] 正常完了:restaurant / 正常完了以外:nil
  # [説　明] 引数のパラメータよりrestaurant情報を取得し、restaurantインスタンスを返す
  def self.get_param_restaurant(params)
    restaurant = Restaurant.new
    restaurant.gurunavi_id = params[:gurunavi_id]
    restaurant.category = params[:category]
    restaurant.name = params[:name]
    restaurant.address = params[:address]
    restaurant.image_url = params[:image_url]
    restaurant.opentime = params[:opentime]
    restaurant.holiday = params[:holiday]
    restaurant.pr_short = params[:pr_short]
    set_mark_restaurant_user_reg(restaurant)
    restaurant
  end

  private

  # [概　要] Restaurantオブジェクトのmark_restaurant_user_regをセットする
  # [引　数] Restaurantオブジェクト
  # [戻り値] Restaurantオブジェクト
  # [説　明] 引数のRestaurantオブジェクト情報のMarkRestaurantテーブルに登録有無を返す
  def self.set_mark_restaurant_user_reg(restaurant)
    # MarkRestaurantテーブルの登録有無をrestaurantインスタンスに格納する
    if MarkRestaurant.exists?(gurunavi_id: restaurant.gurunavi_id)
      restaurant.mark_restaurant_user_reg = true
    else
      restaurant.mark_restaurant_user_reg = false     
    end
  end
end