class MarkRestaurant < ApplicationRecord

  # アソシエーション
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :restaurant, primary_key: 'gurunavi_id',  foreign_key: 'gurunavi_id'

  # 定数
  MARK_RESTAURANT_HASH_ZERO = 0

  # [概　要] ユーザが登録しているmark_restaurantのrestaurant情報を取得
  # [引　数] 対象のユーザID, ログイン中ユーザID
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
  
  # [概　要] mark_restaurantのscore上位num件分のrestaurant情報を取得
  # [引　数] 取得件数
  # [戻り値] restaurant配列
  # [説　明] mark_restaurantに登録されているscoreが高い順にnumの件数分のrestaurant情報取得する
  def self.get_mark_restaurant_info_top(num = 100)
    restaurants = []
    mark_restaurants = MarkRestaurant.group(:gurunavi_id).average(:score)
    mark_restaurants.sort_by{ |u| u[1]}.reverse
    
    # num件分のrestaurant情報を取得し配列に格納
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

  # [概　要] フォローしているユーザの全mark_restaurantのrestaurant情報を取得
  # [引　数] 対象のユーザID, 検索文字列
  # [戻り値] restaurant配列
  # [説　明] 引数の受け渡されたユーザがフォローユーザの全mark_restaurantのrestaurant情報を返す
  # 　　　　　なお、keywordが渡された場合はaddressにkeywordを含むrestaurant情報のみを返す
  def self.get_mark_restaurant_info_following_onry(current_user_id, keyword = nil)
    restaurants = []
    mark_restaurants = User.joins(:MarkRestaurant, :Follow).where(follows: {user_id: current_user_id}, follows:{follow_status: Follow::FOLLOW_STATUS_TYPE_FOLLOWING}).where.not(id: current_user_id).group(:gurunavi_id).average(:score)

    # mark_restaurantのrestaurant情報を取得し配列に格納
    mark_restaurants.each do |mark_restaurant|
      restaurant = Restaurant.new
      restaurant = Restaurant.find_by(gurunavi_id: mark_restaurant[0])
      restaurant = Restaurant.set_accessor(restaurant, current_user_id, current_user_id)
      restaurants << restaurant
    end

    if ! (keyword.nil?)
      restaurants = restaurants.select { |restaurant| restaurant.address.include?(keyword)}
    else
      # nop
    end

    restaurants.sort_by{ |u| u[1]}.reverse
    restaurants
  end
end
