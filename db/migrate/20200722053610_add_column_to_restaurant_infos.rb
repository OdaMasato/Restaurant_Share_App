class AddColumnToRestaurantInfos < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurant_infos, :restaurant_info_id, :string
  end
end
