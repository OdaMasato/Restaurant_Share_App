class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  has_many :MarkRestaurant, primary_key: 'id',foreign_key: 'user_id'
  has_many :Restaurant, through: :MarkRestaurant
  has_many :Follow
end
