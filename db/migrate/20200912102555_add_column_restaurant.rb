class AddColumnRestaurant < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :access_line, :string
    add_column :restaurants, :access_station ,:string
    add_column :restaurants, :access_station_exit, :string
    add_column :restaurants, :access_walk, :string
    add_column :restaurants, :access_note , :string
    add_column :restaurants, :budget , :integer
  end
end
