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

ActiveRecord::Schema.define(version: 20151125083908) do

  create_table "blocks", force: :cascade do |t|
    t.string   "no",            limit: 255,                           null: false
    t.string   "street",        limit: 255,                           null: false
    t.string   "probable_date", limit: 255
    t.string   "delivery_date", limit: 255,                           null: false
    t.string   "lease_start",   limit: 255,                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "estate_id",     limit: 4,                             null: false
    t.decimal  "lat",                       precision: 18, scale: 15
    t.decimal  "long",                      precision: 18, scale: 15
    t.string   "link",          limit: 255
  end

  add_index "blocks", ["estate_id"], name: "index_blocks_on_estate_id", using: :btree
  add_index "blocks", ["no", "street"], name: "index_blocks_on_no_and_street", unique: true, using: :btree

  create_table "estates", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.integer  "total",      limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estates", ["name"], name: "index_estates_on_name", unique: true, using: :btree

  create_table "quota", force: :cascade do |t|
    t.string   "flat_type",  limit: 255, null: false
    t.integer  "malay",      limit: 4,   null: false
    t.integer  "chinese",    limit: 4,   null: false
    t.integer  "others",     limit: 4,   null: false
    t.integer  "block_id",   limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quota", ["block_id"], name: "index_quota_on_block_id", using: :btree
  add_index "quota", ["flat_type", "block_id"], name: "index_quota_on_flat_type_and_block_id", unique: true, using: :btree

  create_table "units", force: :cascade do |t|
    t.string   "no",         limit: 255, null: false
    t.string   "flat_type",  limit: 255, null: false
    t.integer  "block_id",   limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price",      limit: 4,   null: false
    t.integer  "area",       limit: 4,   null: false
    t.integer  "quota_id",   limit: 4,   null: false
    t.string   "price_str",  limit: 255
  end

  add_index "units", ["block_id"], name: "index_units_on_block_id", using: :btree
  add_index "units", ["flat_type"], name: "index_units_on_flat_type", using: :btree
  add_index "units", ["no", "block_id"], name: "index_units_on_no_and_block_id", unique: true, using: :btree
  add_index "units", ["quota_id"], name: "index_units_on_quota_id", using: :btree

end
