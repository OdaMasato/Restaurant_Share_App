class Restaurant < ApplicationRecord
  # ☆mark_restaurant_currentuser_reg_exist名前変えたい
  attr_accessor :mark_restaurant_currentuser_reg_exist

  # has_many :mark_restaurant
end
