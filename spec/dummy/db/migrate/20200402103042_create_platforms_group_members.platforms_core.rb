# This migration comes from platforms_core (originally 20200308091141)
class CreatePlatformsGroupMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :platforms_group_members do |t|
      t.integer :platforms_group_id
      t.integer :platforms_user_id
      t.integer :role

      t.timestamps
    end
    add_index :platforms_group_members, [:platforms_group_id, :platforms_user_id],
      name: "platforms_group_members_index"
  end
end
