class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :rest_id
      t.string :image_url
      t.string :opentime
      t.string :holiday
      t.string :pr_short
      t.string :address

      t.timestamps
    end
  end
end
