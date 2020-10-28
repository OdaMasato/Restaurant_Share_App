class CreateWentRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :went_restaurants do |t|
      t.integer :user_id
      t.string :gurunavi_id

      t.timestamps
    end
  end
end
