class WentRestaurant < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :restaurant,primary_key: 'gurunavi_id',  foreign_key: 'gurunavi_id'

  # [概　要] ユーザが登録しているwent_restaurantのrestaurant情報を取得
  # [引　数] 対象のユーザID, ログイン中ユーザID
  # [戻り値] Restaurantオブジェクト
  # [説　明] 引数で指定されたユーザが登録しているwent_restaurantのrestaurant情報を返す
  def self.get_went_restaurant_info(user_id, current_user_id = user_id)
    went_restaurants = WentRestaurant.where(user_id: user_id)
    restaurants = []

    # went_restaurantのrestaurant情報を取得し配列に格納
    went_restaurants.each do |went_restaurant|
      restaurant = Restaurant.new
      restaurant = went_restaurant.restaurant
      restaurant = Restaurant.set_accessor(restaurant, user_id, current_user_id)
      restaurants << restaurant
    end
    restaurants
  end
end
