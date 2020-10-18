class MarkRestaurant < ApplicationRecord

  # アソシエーション
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :restaurant, primary_key: 'gurunavi_id',  foreign_key: 'gurunavi_id'

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
    restaurants.sort_by{ |u| u[1]}.reverse
  end

  # [概　要] mark_restaurantのscore上位10件のrestaurant情報を取得
  # [引　数] なし
  # [戻り値] restaurant配列
  # [説　明] mark_restaurantに登録されているscoreが高い順にnumの件数、restaurant情報取得する
  def self.get_mark_restaurant_info_top(num = 100)

    restaurants = []
    # mark_restaurants = MarkRestaurant.group(:gurunavi_id).average(:score).sort_by{ |u| u.score}.reverse
    mark_restaurants = MarkRestaurant.group(:gurunavi_id).average(:score)
    mark_restaurants.sort_by{ |u| u[1]}.reverse
    
    # 10件分のrestaurant情報を取得し配列に格納
    num -=1
    mark_restaurants.each_with_index do |mark_restaurant, i|
      restaurant = Restaurant.new
      restaurant = Restaurant.find_by(gurunavi_id: mark_restaurant[MARK_RESTAURANT_HASH_ZERO])
      restaurant = Restaurant.set_accessor(restaurant)
      restaurants << restaurant
      break if i == num
    end

    restaurants
  end
end
