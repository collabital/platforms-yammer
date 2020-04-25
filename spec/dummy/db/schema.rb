# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_02_103043) do

  create_table "platforms_certificates", force: :cascade do |t|
    t.string "client_id"
    t.string "client_secret"
    t.string "name"
    t.string "strategy"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "platforms_group_members", force: :cascade do |t|
    t.integer "platforms_group_id"
    t.integer "platforms_user_id"
    t.integer "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["platforms_group_id", "platforms_user_id"], name: "platforms_group_members_index"
  end

  create_table "platforms_groups", force: :cascade do |t|
    t.string "platform_id"
    t.string "name"
    t.integer "platforms_network_id"
    t.string "web_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["platform_id", "platforms_network_id"], name: "index_platforms_groups_on_platform_id_and_platforms_network_id"
  end

  create_table "platforms_networks", force: :cascade do |t|
    t.string "platform_id"
    t.string "platform_type"
    t.string "name"
    t.string "permalink"
    t.boolean "trial"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["platform_id", "platform_type"], name: "platforms_ids"
    t.index ["platform_id"], name: "index_platforms_networks_on_platform_id"
  end

  create_table "platforms_tags", force: :cascade do |t|
    t.string "platform_id"
    t.string "name"
    t.integer "platforms_network_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["platform_id", "platforms_network_id"], name: "index_platforms_tags_on_platform_id_and_platforms_network_id"
  end

  create_table "platforms_users", force: :cascade do |t|
    t.string "platform_id"
    t.string "name"
    t.string "thumbnail_url"
    t.boolean "admin"
    t.string "web_url"
    t.string "email"
    t.integer "platforms_network_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["platform_id", "platforms_network_id"], name: "index_platforms_users_on_platform_id_and_platforms_network_id"
  end

end
