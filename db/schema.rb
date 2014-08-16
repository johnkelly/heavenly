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

ActiveRecord::Schema.define(version: 20140815064818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "pg_stat_statements"

  create_table "accounts", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "type",                  null: false
    t.uuid     "person_id",             null: false
    t.string   "provider_id",           null: false
    t.string   "provider",              null: false
    t.string   "card_brand",            null: false
    t.string   "card_funding",          null: false
    t.integer  "card_last_four",        null: false
    t.integer  "card_expiration_month", null: false
    t.integer  "card_expiration_year",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["person_id"], name: "index_accounts_on_person_id", using: :btree
  add_index "accounts", ["provider_id"], name: "index_accounts_on_provider_id", using: :btree
  add_index "accounts", ["type"], name: "index_accounts_on_type", using: :btree

  create_table "addresses", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "person_id",                            null: false
    t.string   "street1",                              null: false
    t.string   "street2"
    t.string   "city",                                 null: false
    t.string   "region",                               null: false
    t.string   "postal_code",                          null: false
    t.string   "country",                              null: false
    t.decimal  "latitude",    precision: 10, scale: 6, null: false
    t.decimal  "longitude",   precision: 10, scale: 6, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["latitude"], name: "index_addresses_on_latitude", using: :btree
  add_index "addresses", ["longitude"], name: "index_addresses_on_longitude", using: :btree
  add_index "addresses", ["person_id"], name: "index_addresses_on_person_id", using: :btree

  create_table "auth_providers", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "type",                               null: false
    t.uuid     "person_id",                          null: false
    t.string   "provider_person_id",                 null: false
    t.string   "token",                              null: false
    t.datetime "expiration",                         null: false
    t.string   "link",                               null: false
    t.boolean  "verified",           default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auth_providers", ["person_id"], name: "index_auth_providers_on_person_id", using: :btree
  add_index "auth_providers", ["provider_person_id"], name: "index_auth_providers_on_provider_person_id", using: :btree
  add_index "auth_providers", ["token"], name: "index_auth_providers_on_token", using: :btree
  add_index "auth_providers", ["type"], name: "index_auth_providers_on_type", using: :btree

  create_table "people", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "auth_token", null: false
    t.string   "email",      null: false
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.string   "gender",     null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["auth_token"], name: "index_people_on_auth_token", unique: true, using: :btree

end
