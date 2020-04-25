# This migration comes from platforms_core (originally 20200308091123)
class CreatePlatformsTags < ActiveRecord::Migration[6.0]
  def change
    create_table :platforms_tags do |t|
      t.string :platform_id
      t.string :name
      t.integer :platforms_network_id

      t.timestamps
    end
    add_index :platforms_tags, [:platform_id, :platforms_network_id]
  end
end
