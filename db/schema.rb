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

ActiveRecord::Schema.define(version: 20140508050527) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "base_units", force: true do |t|
    t.string   "name",        limit: 100, null: false
    t.integer  "base_width",              null: false
    t.integer  "base_length",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trays", force: true do |t|
    t.integer  "base_unit_id"
    t.integer  "files",                       null: false
    t.integer  "ranks",                       null: false
    t.float    "gap_percent",  default: 0.05, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trays", ["base_unit_id"], name: "index_trays_on_base_unit_id", using: :btree

end
