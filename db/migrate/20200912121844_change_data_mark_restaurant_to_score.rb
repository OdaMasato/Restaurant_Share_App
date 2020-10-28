class ChangeDataMarkRestaurantToScore < ActiveRecord::Migration[6.0]
  def change
    change_column :mark_restaurants, :score, :float
  end
end
