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

ActiveRecord::Schema.define(version: 2018_10_15_184722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "email", limit: 255, null: false
    t.string "password_digest", limit: 255, null: false
    t.jsonb "sessions", default: [], null: false
    t.jsonb "recovery", default: {}, null: false
    t.datetime "remember_created_at"
    t.jsonb "tracking", default: {}, null: false
    t.jsonb "confirmation", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["sessions"], name: "index_users_on_sessions_jsonb_path_ops", opclass: :jsonb_path_ops, using: :gin
  end

end
