class MarkRestaurant < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant,primary_key: 'gurunavi_id',  foreign_key: 'gurunavi_id'
end
