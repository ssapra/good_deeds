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

ActiveRecord::Schema.define(version: 20150724183811) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "congressional_districts", force: :cascade do |t|
    t.string   "zipcode"
    t.string   "state"
    t.integer  "congressional_district_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "congressional_districts", ["state"], name: "index_congressional_districts_on_state", using: :btree
  add_index "congressional_districts", ["zipcode"], name: "index_congressional_districts_on_zipcode", using: :btree

  create_table "legislators", force: :cascade do |t|
    t.string   "title"
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.string   "name_suffix"
    t.string   "nickname"
    t.string   "party"
    t.string   "state"
    t.string   "district"
    t.string   "in_office"
    t.string   "gender"
    t.string   "phone"
    t.string   "fax"
    t.string   "website"
    t.string   "webform"
    t.string   "congress_office"
    t.string   "bioguide_id"
    t.string   "votesmart_id"
    t.string   "fec_id"
    t.string   "govtrack_id"
    t.string   "crp_id"
    t.string   "twitter_id"
    t.string   "congresspedia_url"
    t.string   "youtube_url"
    t.string   "facebook_id"
    t.string   "official_rss"
    t.string   "senate_class"
    t.string   "birthdate"
    t.string   "oc_email"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_tags", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "zipcode"
    t.string   "political_party"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
