class CreateMarkRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :mark_restaurants do |t|
      t.integer :user_id
      t.string :gurunavi_id
      t.integer :score

      t.timestamps
    end
  end
end
