class MarkRestaurant < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :restaurant, primary_key: 'gurunavi_id',  foreign_key: 'gurunavi_id'
  belongs_to :follows, primary_key: 'user_id', foreign_key: 'follow_id'

  # [概　要] ユーザが登録しているmark_restaurantのrestaurant情報を取得
  # [引　数] User::user_id
  # [戻り値] restaurant配列
  # [説　明] 引数で指定されたユーザが登録しているmark_restaurantのrestaurant情報を返す
  def self.get_mark_restaurant_info(user_id, current_user_id = user_id)

    mark_restaurants = MarkRestaurant.where(user_id: user_id)
    restaurants = []

    # mark_restaurantのrestaurant情報を取得し配列に格納
    mark_restaurants.each do |mark_restaurant|
      restaurant = Restaurant.new
      restaurant = mark_restaurant.restaurant
      restaurant = Restaurant.set_accessor(restaurant, user_id, current_user_id)
      restaurants << restaurant
    end
    restaurants
  end
end
