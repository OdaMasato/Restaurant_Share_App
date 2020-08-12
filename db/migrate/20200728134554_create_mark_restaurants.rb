class CreateMarkRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :mark_restaurants do |t|
      t.string :user_id
      t.string :gurunavi_id

      t.timestamps
    end
  end
end
