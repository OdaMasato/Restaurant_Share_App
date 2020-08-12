class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :gurunavi_id
      t.string :image_url
      t.string :opentime
      t.string :holiday
      t.string :pr_short
      t.string :address
      t.string :name
      t.string :category

      t.timestamps
    end
  end
end
