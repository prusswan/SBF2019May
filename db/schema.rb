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

ActiveRecord::Schema.define(version: 20180524070937) do

  create_table "blocks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "no",                                       null: false
    t.string   "street",                                   null: false
    t.string   "probable_date"
    t.string   "delivery_date",                            null: false
    t.string   "lease_start",                              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "estate_id",                                null: false
    t.decimal  "lat",            precision: 18, scale: 15
    t.decimal  "long",           precision: 18, scale: 15
    t.string   "link"
    t.json     "geocode_result"
    t.index ["estate_id"], name: "index_blocks_on_estate_id", using: :btree
    t.index ["no", "street"], name: "index_blocks_on_no_and_street", unique: true, using: :btree
  end

  create_table "estates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name",       null: false
    t.integer  "total",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_estates_on_name", unique: true, using: :btree
  end

  create_table "quota", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "flat_type",  null: false
    t.integer  "malay",      null: false
    t.integer  "chinese",    null: false
    t.integer  "others",     null: false
    t.integer  "block_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["block_id"], name: "index_quota_on_block_id", using: :btree
    t.index ["flat_type", "block_id"], name: "index_quota_on_flat_type_and_block_id", unique: true, using: :btree
  end

  create_table "units", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "no",         null: false
    t.string   "flat_type",  null: false
    t.integer  "block_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price",      null: false
    t.integer  "area",       null: false
    t.integer  "quota_id",   null: false
    t.string   "price_str"
    t.index ["block_id"], name: "index_units_on_block_id", using: :btree
    t.index ["flat_type"], name: "index_units_on_flat_type", using: :btree
    t.index ["no", "block_id"], name: "index_units_on_no_and_block_id", unique: true, using: :btree
    t.index ["quota_id"], name: "index_units_on_quota_id", using: :btree
  end

end
