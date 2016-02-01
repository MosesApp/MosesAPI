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

ActiveRecord::Schema.define(version: 20160201212326) do

  PRAGMA FOREIGN_KEYS = ON;
  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "full_name"
    t.string   "email"
    t.string   "facebook_id", index: {name: "fk__users_facebook_id"}, foreign_key: {references: "facebooks", name: "fk_users_facebook_id", on_update: :no_action, on_delete: :no_action}
    t.string   "locale"
    t.integer  "timezone"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "creator_id",         index: {name: "fk__groups_creator_id"}, foreign_key: {references: "users", name: "fk_groups_creator_id", on_update: :no_action, on_delete: :no_action}
    t.string   "status"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end
