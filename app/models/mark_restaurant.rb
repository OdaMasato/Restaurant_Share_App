class MarkRestaurant < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant_info
end
