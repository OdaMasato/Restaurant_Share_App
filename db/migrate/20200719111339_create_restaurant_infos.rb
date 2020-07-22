class CreateRestaurantInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurant_infos do |t|
      t.string :address
      t.string :image_url_shop_image1
      t.string :opentime
      t.string :holiday
      t.string :pr_short

      t.timestamps
    end
  end
end
