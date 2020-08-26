class Restaurant < ApplicationRecord

  # アソシエーション
  has_many :MarkRestaurant,primary_key: 'gurunavi_id', foreign_key: 'gurunavi_id'
  has_many :User, through: :MarkRestaurant

  # accessor
  attr_accessor :mark_restaurant_user_reg ,:went_restaurant_user_reg

  # [概　要] ぐるなびのレストラン検索APIのレスポンスパラメータからrestaurant配列を取得
  # [引　数] ぐるなび レストラン検索APIレスポンスパラメータ(json)
  # [戻り値] 正常完了:restaurant[] / 正常完了以外:nil
  # [説　明] 引数のパラメータより飲食店情報を取得し、restaurant配列として返す
  def self.get_gurunavi_params_restaurants_arg(params)
    restaurants = []
    params = params[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_REST]

    params.each do |param|
      restaurant = Restaurant.new
      restaurant.gurunavi_id = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_ID]
      restaurant.category = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_CATEGORY]
      restaurant.name = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_NAME]
      restaurant.address = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_ADDRESS]
      restaurant.image_url = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_IMAGE_URL][Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_IMAGE_SHOP_IMAGE1]
      restaurant.opentime = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_OPENTIME]
      restaurant.holiday = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_HORIDAY]
      restaurant.pr_short = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_PR_SHORT]
      restaurant.tel = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_TEL]
      restaurant.gurunavi_url = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_URL]
      set_mark_restaurant_user_reg(restaurant)
      set_went_restaurant_user_reg(restaurant)
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
    restaurant.tel = params[:tel]
    restaurant.gurunavi_url = params[:gurunavi_url]
    set_mark_restaurant_user_reg(restaurant)
    set_went_restaurant_user_reg(restaurant)
    restaurant
  end

  # [概　要] ぐるなびのレストラン検索APIのレスポンスパラメータからrestaurant配列を取得
  # [引　数] ぐるなび レストラン検索APIレスポンスパラメータ(json)
  # [戻り値] 正常完了:restaurant[] / 正常完了以外:nil
  # [説　明] 引数のパラメータより飲食店情報を取得し、restaurant配列として返す
  def self.get_user_mark_restaurants_arg(user_id)
    restaurants = []
    params = params[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_REST]

    params.each do |param|
      restaurant = Restaurant.new
      restaurant.gurunavi_id = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_ID]
      restaurant.category = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_CATEGORY]
      restaurant.name = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_NAME]
      restaurant.address = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_ADDRESS]
      restaurant.image_url = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_IMAGE_URL][Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_IMAGE_SHOP_IMAGE1]
      restaurant.opentime = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_OPENTIME]
      restaurant.holiday = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_HORIDAY]
      restaurant.pr_short = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_PR_SHORT]
      restaurant.tel = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_TEL]
      restaurant.gurunavi_url = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_URL]
      set_mark_restaurant_user_reg(restaurant)
      set_went_restaurant_user_reg(restaurant)
      restaurants << restaurant
    end
    restaurants
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

  # [概　要] Restaurantオブジェクトのwent_restaurant_user_regをセットする
  # [引　数] Restaurantオブジェクト
  # [戻り値] Restaurantオブジェクト
  # [説　明] 引数のRestaurantオブジェクト情報のWentRestaurantテーブルに登録有無を返す
  def self.set_went_restaurant_user_reg(restaurant)
    # WentRestaurantテーブルの登録有無をrestaurantインスタンスに格納する
    if WentRestaurant.exists?(gurunavi_id: restaurant.gurunavi_id)
      restaurant.went_restaurant_user_reg = true
    else
      restaurant.went_restaurant_user_reg = false     
    end
  end
end