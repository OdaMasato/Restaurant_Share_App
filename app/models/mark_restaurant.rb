class MarkRestaurant < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :restaurant, primary_key: 'gurunavi_id',  foreign_key: 'gurunavi_id'
  belongs_to :follows, primary_key: 'user_id', foreign_key: 'follow_id'

  # 定数
  MARK_RESTAURANT_HASH_ZERO = 0

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

  # [概　要] mark_restaurantのscore上位10件のrestaurant情報を取得
  # [引　数] なし
  # [戻り値] restaurant配列
  # [説　明] score上位10件のrestaurant情報を取得返す
  def self.get_mark_restaurant_info_top_10()

    restaurants = []
    # mark_restaurants = MarkRestaurant.group(:gurunavi_id).average(:score).sort_by{ |u| u.score}.reverse
    mark_restaurants = MarkRestaurant.group(:gurunavi_id).average(:score)
    
    # 10件分のrestaurant情報を取得し配列に格納
    mark_restaurants.each_with_index do |mark_restaurant, i|
      restaurant = Restaurant.new
      restaurant = Restaurant.find_by(gurunavi_id: mark_restaurant[MARK_RESTAURANT_HASH_ZERO])
      restaurant = Restaurant.set_accessor(restaurant)
      restaurants << restaurant
      break if i== 3
    end

    restaurants
  end
end
