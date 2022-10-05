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

ActiveRecord::Schema.define(version: 2022_10_04_183959) do

  create_table "favorites", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.integer "player_id"
    t.boolean "flex"
    t.boolean "defense"
    t.string "position"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "position"
    t.integer "number"
    t.string "status"
    t.boolean "is_drafted"
    t.string "team_name"
    t.string "team_location"
    t.string "team_logo"
    t.string "image"
    t.string "catagory"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.integer "player_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

end
