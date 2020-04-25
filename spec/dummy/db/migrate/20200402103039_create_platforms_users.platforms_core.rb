# This migration comes from platforms_core (originally 20200308091113)
class CreatePlatformsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :platforms_users do |t|
      t.string :platform_id
      t.string :name
      t.string :thumbnail_url
      t.boolean :admin
      t.string :web_url
      t.string :email
      t.integer :platforms_network_id

      t.timestamps
    end
    add_index :platforms_users, [:platform_id, :platforms_network_id]
  end
end
