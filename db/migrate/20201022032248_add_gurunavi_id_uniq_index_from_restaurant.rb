class AddGurunaviIdUniqIndexFromRestaurant < ActiveRecord::Migration[6.0]
  def change
    add_index :restaurants, :gurunavi_id, unique: true
  end
end
