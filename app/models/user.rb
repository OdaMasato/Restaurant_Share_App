class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  # ☆開発用に一時コメントアウト
  # , :confirmable

  # アソシエーション
  has_many :MarkRestaurant,foreign_key: 'user_id'
  has_many :Restaurant, through: :MarkRestaurant

  has_many :WentRestaurant,foreign_key: 'user_id'
  has_many :Restaurant, through: :WentRestaurant
  has_many :Follow,foreign_key: 'user_id'

  mount_uploader :image, ImageUploader

  # accessor
  attr_accessor :followings_count ,:followers_count, :is_current_user_following

  # [概　要] ユーザ情報を取得
  # [引　数] User::user_id
  # [戻り値] 正常完了:0以上の整数 / 正常完了以外:0
  # [説　明] 引数で指定されたユーザIDのユーザ情報を返す
  def self.get_user_info(user_id, current_user_id)
    user = User.find_by(id: user_id)
    set_accessor(user, current_user_id)
  end

  # [概　要] Userオブジェクトのaccessorに値を代入する
  # [引　数] User::user_id,User::Userオブジェクト
  # [戻り値] Userオブジェクト
  # [説　明] Userオブジェクトのaccesorに値をセットする
  def self.set_accessor(user_info, current_user_id)

    follow = Follow.find_by(user_id: current_user_id, follow_id: user_info.id)

    if user_info.id == current_user_id
      user_info.is_current_user_following = Follow::FOLLOW_STATUS_TYPE_MYSELF
    elsif follow.nil?
      user_info.is_current_user_following = Follow::FOLLOW_STATUS_TYPE_NON_FOLLOWING      
    else
      user_info.is_current_user_following = follow.follow_status
    end

    user_info.followings_count = Follow.where(user_id: user_info, follow_status: Follow::FOLLOW_STATUS_TYPE_FOLLOWING).count
    user_info.followers_count = Follow.where(follow_id: user_info, follow_status: Follow::FOLLOW_STATUS_TYPE_FOLLOWING).count
    user_info
  end

  # [概　要] パスワード入力無でユーザ情報更新を行う。本メソッドはDeviseクラスのメソッドのオーバライド。
  # [説　明] パスワード入力無でユーザ情報更新を行う。
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
