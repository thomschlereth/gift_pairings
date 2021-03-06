# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190921235916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groupings", force: :cascade do |t|
    t.string "name"
  end

  create_table "occasions", force: :cascade do |t|
    t.string "title"
    t.string "year"
  end

  create_table "occasions_users", force: :cascade do |t|
    t.integer "occasion_id"
    t.integer "user_id"
    t.integer "giver_id"
    t.integer "reciever_id"
    t.index ["giver_id"], name: "index_occasions_users_on_giver_id", using: :btree
    t.index ["occasion_id"], name: "index_occasions_users_on_occasion_id", using: :btree
    t.index ["reciever_id"], name: "index_occasions_users_on_reciever_id", using: :btree
    t.index ["user_id"], name: "index_occasions_users_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "username"
    t.string  "password_digest"
    t.integer "grouping_id"
    t.boolean "first_time_toggle", default: true
    t.string  "email"
    t.index ["grouping_id"], name: "index_users_on_grouping_id", using: :btree
  end

  add_foreign_key "occasions_users", "occasions"
  add_foreign_key "occasions_users", "occasions_users", column: "giver_id"
  add_foreign_key "occasions_users", "occasions_users", column: "reciever_id"
  add_foreign_key "occasions_users", "users"
  add_foreign_key "users", "groupings"
end
