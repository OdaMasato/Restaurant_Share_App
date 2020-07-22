class CreateFollowUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :follow_users do |t|
      t.integer :user_id
      t.string :follow_userid

      t.timestamps
    end
  end
end
