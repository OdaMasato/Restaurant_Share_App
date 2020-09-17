class Follow < ApplicationRecord

  # [概　要] フォロー中のユーザ数を取得
  # [引　数] User::user_id
  # [戻り値] 正常完了:0以上の整数 / 正常完了以外:0
  # [説　明] 引数で指定されたユーザがフォローしているユーザ数を返す
  def self.get_follow_count(user_id)
    Follow.where(user_id: user_id).count 
  end

  # [概　要] フォローされているユーザ数を取得
  # [引　数] User::user_id
  # [戻り値] 正常完了:0以上の整数 / 正常完了以外:0
  # [説　明] 引数で指定されたユーザをフォローしているユーザ数を返す
  def self.get_followee_count(user_id)
    Follow.where(follow_id: user_id).count
  end

end
