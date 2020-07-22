class CreateMarkRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :mark_restaurants do |t|
      t.integer :user_id
      t.integer :restaurant_info_id

      t.timestamps
    end
  end
end
