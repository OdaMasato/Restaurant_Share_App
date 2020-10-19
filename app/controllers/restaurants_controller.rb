class RestaurantsController < ApplicationController
  require 'Gurunavi'

  def index

    @is_disp_filter = params[:is_disp_filter]
    @is_disp_filter = false if @is_disp_filter.nil?

    if (false == @is_disp_filter)
      # RECOMMEND FILTERが未チェックの場合
      # ぐるなびレストラン検索APIのフリワード検索URLを取得
      url = Gurunavi.get_freeword_search_url(params[:search],Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_REQ_HIT_COUNT_DEFAULT)

      # フリワード検索を行い、ハッシュ化したレスポンス(json)を取得
      results = Gurunavi.get_http_res_json(url)

      if !(results.nil?)
        # 取得成功の場合
        # レスポンスからRestaurant情報を取得
        @restaurants = Restaurant.get_gurunavi_params_restaurants_arg(results)
        @restaurants = Restaurant.set_accessor(@restaurants, current_user.id)
        @restaurants = Kaminari.paginate_array(@restaurants).page(params[:page])
      else
        # 取得失敗の場合
        # nop
      end
    else
      # ログイン中ユーザがフォローしているユーザの全mark_restaurantのrestaurant情報を取得する
      @restaurants = MarkRestaurant.get_mark_restaurant_info_following_onry(current_user.id)
      @restaurants = Kaminari.paginate_array(@restaurants).page(params[:page])
    end
  end

  def show
    @restaurant = Restaurant.get_param_restaurant(params)
    @restaurant = Restaurant.set_accessor(@restaurant, current_user.id)
    
    @follows = []

    if MarkRestaurant.exists?(user_id: current_user.id, gurunavi_id: @restaurant.gurunavi_id)
      user = User.new
      user = User.get_user_info(current_user.id, current_user.id)
      user.evaluated_restaurant_score = MarkRestaurant.find_by(user_id: current_user.id, gurunavi_id: @restaurant.gurunavi_id).score
      @follows << user
    else
      # nop
    end
    
    followings = User.joins(:MarkRestaurant, :Follow).where(follows: {user_id: current_user.id}, follows:{follow_status: Follow::FOLLOW_STATUS_TYPE_FOLLOWING}, mark_restaurants: {gurunavi_id: @restaurant.gurunavi_id})
    followings.each do |following|
      user = User.new
      user = User.get_user_info(following.id, current_user.id)
      user.evaluated_restaurant_score = MarkRestaurant.find_by(user_id: following.id, gurunavi_id: @restaurant.gurunavi_id).score
      @follows << user
    end

    @follows = Kaminari.paginate_array(@follows).page(params[:page])
  end
end