class WentRestaurant < ApplicationRecord
  belongs_to :User
  belongs_to :Restaurant
end
