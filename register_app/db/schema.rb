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

ActiveRecord::Schema.define(version: 20150301114101) do

  create_table "applications", force: :cascade do |t|
    t.string   "key"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "api_user_id"
  end

  add_index "applications", ["api_user_id"], name: "index_applications_on_api_user_id"
  add_index "applications", ["created_at"], name: "index_applications_on_user_id_and_created_at"

  create_table "calls", force: :cascade do |t|
    t.text     "ip"
    t.text     "caller"
    t.integer  "application_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "calls", ["application_id", "created_at"], name: "index_calls_on_application_id_and_created_at"
  add_index "calls", ["application_id"], name: "index_calls_on_application_id"

  create_table "event_tags", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "event_tags", ["event_id"], name: "index_event_tags_on_event_id"
  add_index "event_tags", ["tag_id"], name: "index_event_tags_on_tag_id"

  create_table "events", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "position_id"
    t.integer  "end_user_id"
    t.integer  "application_id"
    t.text     "content"
  end

  add_index "events", ["application_id"], name: "index_events_on_application_id"
  add_index "events", ["end_user_id", "created_at"], name: "index_events_on_end_user_id_and_created_at"
  add_index "events", ["end_user_id"], name: "index_events_on_end_user_id"
  add_index "events", ["position_id"], name: "index_events_on_position_id"

  create_table "positions", force: :cascade do |t|
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "street"
    t.text     "city"
    t.text     "state"
    t.text     "country"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.string   "type"
    t.integer  "application_id"
  end

  add_index "users", ["application_id"], name: "index_users_on_application_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
