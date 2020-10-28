class AddColumnFollows < ActiveRecord::Migration[6.0]
  def change
    add_column :follows, :follow_status, :integer
  end
end
