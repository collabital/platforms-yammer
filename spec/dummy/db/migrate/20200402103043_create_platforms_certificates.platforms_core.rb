# This migration comes from platforms_core (originally 20200313102128)
class CreatePlatformsCertificates < ActiveRecord::Migration[6.0]
  def change
    create_table :platforms_certificates do |t|
      t.string :client_id
      t.string :client_secret
      t.string :name
      t.string :strategy

      t.timestamps
    end
  end
end
