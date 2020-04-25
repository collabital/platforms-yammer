# This migration comes from platforms_core (originally 20200308091132)
class CreatePlatformsGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :platforms_groups do |t|
      t.string :platform_id
      t.string :name
      t.integer :platforms_network_id
      t.string :web_url

      t.timestamps
    end
    add_index :platforms_groups, [:platform_id, :platforms_network_id]
  end
end
