# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120614091535) do

  create_table "games", :force => true do |t|
    t.integer  "black_team_score"
    t.integer  "yellow_team_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.float    "elo"
    t.integer  "games_played"
    t.integer  "wins"
    t.integer  "losses"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gravatar_id"
  end

  create_table "rounds", :force => true do |t|
    t.integer  "game_id"
    t.integer  "round_number"
    t.integer  "black_team_score"
    t.integer  "yellow_team_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.integer  "game_id"
    t.integer  "first_player_id"
    t.integer  "second_player_id"
    t.boolean  "black_team"
    t.boolean  "first_player_on_defense"
    t.boolean  "first_to_switch"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
