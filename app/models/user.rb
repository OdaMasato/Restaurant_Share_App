class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  # ☆開発用に一時コメントアウト
  # , :confirmable

  has_many :MarkRestaurant,foreign_key: 'user_id'
  has_many :Restaurant, through: :MarkRestaurant

  has_many :WentRestaurant,foreign_key: 'user_id'
  has_many :Restaurant, through: :WentRestaurant
  has_many :Follow

  # [概　要] ユーザ情報を取得
  # [引　数] User::user_id
  # [戻り値] 正常完了:0以上の整数 / 正常完了以外:0
  # [説　明] 引数で指定されたユーザIDのユーザ情報を返す
  def self.get_user_info(user_id)
    User.find_by(id: user_id)
  end
end
