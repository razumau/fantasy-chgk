# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_11_172648) do
  create_table "collections", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_collections_on_game_id"
    t.index ["player_id"], name: "index_collections_on_player_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.datetime "deadline", null: false
    t.integer "points_limit", null: false
    t.integer "teams_limit", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "picks", force: :cascade do |t|
    t.integer "collection_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_id"
    t.index ["collection_id"], name: "index_picks_on_collection_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.string "city", null: false
    t.integer "price", null: false
    t.integer "points"
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_teams_on_game_id"
  end

  add_foreign_key "collections", "games"
  add_foreign_key "collections", "players"
  add_foreign_key "picks", "collections"
  add_foreign_key "picks", "teams"
  add_foreign_key "teams", "games"
end
