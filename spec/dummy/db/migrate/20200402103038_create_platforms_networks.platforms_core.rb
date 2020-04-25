# This migration comes from platforms_core (originally 20200308091104)
class CreatePlatformsNetworks < ActiveRecord::Migration[6.0]
  def change
    create_table :platforms_networks, force: :cascade do |t|
      t.string :platform_id
      t.string :platform_type
      t.string :name
      t.string :permalink
      t.boolean :trial

      t.timestamps
    end
    add_index :platforms_networks, :platform_id
    add_index :platforms_networks, [:platform_id, :platform_type],
      name: "platforms_ids"
  end
end
