class MarkRestaurant < ApplicationRecord
  belongs_to :user, foreign_key: 'id'
  belongs_to :Restaurant, primary_key: 'gurunavi_id', foreign_key: 'gurunavi_id'
end
