class Follow < ApplicationRecord

  # アソシエーション
  belongs_to :user

  # 定数
  GET_FOLLOWS_INFO_TYPE_FOLLOWINGS = 0 #get_follows_infoでフォロー中user情報取得指定用定数
  GET_FOLLOWS_INFO_TYPE_FOLLOWERS = 1 #get_follows_infoでフォローされているuser情報取得指定用定数
  
  # [概　要] ユーザのフォロー情報を取得
  # [引　数] User::user_id, user情報種別(GET_FOLLOWS_INFO_TYPE), User::users_info[]
  # [戻り値] User配列
  # [説　明] 引数で指定されたユーザのフォロー情報を返す
  def self.get_follows_info(user_id, type = GET_FOLLOWS_INFO_TYPE_FOLLOWINGS, users_info = nil)

    users = []
    find_by_type = ""

    if users_info.nil?
      if GET_FOLLOWS_INFO_TYPE_FOLLOWINGS == type
        # フォロー中userの情報取得の場合
        follow_users = Follow.where(user_id: user_id)
        find_by_type = "User.find_by(id: follow_user.follow_id)"      
      elsif GET_FOLLOWS_INFO_TYPE_FOLLOWERS == type
        # フォローされているuserの情報取得の場合
        follow_users = Follow.where(follow_id: user_id)
        find_by_type = "User.find_by(id: follow_user.user_id)"
      else
        # nop
      end

      # following_usersのuser情報を取得し配列に格納
      follow_users.each do |follow_user|
        user = User.new
        user = eval(find_by_type)
        user.is_current_user_following = Follow.exists?(user_id: user_id, follow_id: user.id)
        user.followings_count = Follow.where(user_id: follow_user.id).count
        user.followers_count = Follow.where(follow_id: follow_user.id).count
        users << user
      end

    else
      users_info.each do |user|
        user.is_current_user_following = Follow.exists?(user_id: user_id, follow_id: user.id)
        user.followings_count = Follow.where(user_id: user.id).count
        user.followers_count = Follow.where(follow_id: user.id).count
        users << user
      end
    end

    users.sort_by{ |a| a.followers_count}.reverse

  end
end
