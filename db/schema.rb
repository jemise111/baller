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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140329192625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.text     "body"
    t.boolean  "approved"
    t.datetime "created_at"
    t.integer  "court_id"
    t.integer  "user_id"
  end

  create_table "courts", force: true do |t|
    t.string  "name"
    t.string  "location"
    t.string  "borough"
    t.integer "num_courts"
    t.float   "latitude"
    t.float   "longitude"
  end

  create_table "games", force: true do |t|
    t.datetime "start_at"
    t.datetime "created_at"
    t.integer  "skill_level"
    t.integer  "creator_id"
    t.integer  "court_id"
  end

  create_table "games_users", id: false, force: true do |t|
    t.integer "game_id"
    t.integer "user_id"
  end

  create_table "users", force: true do |t|
    t.boolean  "admin"
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "zip_code"
    t.boolean  "email_display"
    t.boolean  "notifications"
    t.datetime "created_at"
  end

end
