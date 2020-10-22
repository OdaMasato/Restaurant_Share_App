class Follow < ApplicationRecord

  # アソシエーション
  belongs_to :user

  # 定数
  FOLLOW_STATUS_TYPE_MYSELF = -1 # フォロー状態：自分自身
  FOLLOW_STATUS_TYPE_NON_FOLLOWING = 0 # フォロー状態：無
  FOLLOW_STATUS_TYPE_FOLLOWING = 1 # フォロー状態：フォロー中
  FOLLOW_STATUS_TYPE_REQUEST = 2 # フォロー状態：リクエスト中
  FOLLOW_STATUS_TYPE_REQUEST_TO_YOU = 3 # フォロー状態：相手からリクエスト中
  
  # [概　要] ユーザのフォロー情報を取得
  # [引　数] User::user_id, User::users_info[]
  # [戻り値] User配列
  # [説　明] 引数で指定されたユーザのフォロー情報を返す。users_infoが受け渡された場合はuser_idで指定されたユーザ観点でフォロー情報をusers_infoに代入して返す
  def self.get_follows_info(user_info, current_user_id = nil)

    users = []
    find_by_type = ""

    if User != user_info.class
      user_info.each do |user|
        users << User.set_accessor(user, current_user_id)
      end
    else
      follow_users = Follow.where(user_id: user_info)

      # following_usersのuser情報を取得し配列に格納
      follow_users.each do |follow_user|
        user = User.new
        user = User.find_by(id: follow_user.follow_id)
        users << User.set_accessor(user, current_user_id)
      end
    end

    users.sort_by{ |a| a.followers_count}.reverse

  end

end
