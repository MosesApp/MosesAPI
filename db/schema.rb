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

ActiveRecord::Schema.define(version: 20160204223132) do

  PRAGMA FOREIGN_KEYS = ON;
  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "full_name"
    t.string   "email"
    t.string   "facebook_id"
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

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "users_id",       null: false, index: {name: "fk__oauth_access_grants_users_id"}, foreign_key: {references: "users", name: "fk_oauth_access_grants_users_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "application_id", null: false, index: {name: "fk__oauth_access_grants_application_id"}, foreign_key: {references: "applications", name: "fk_oauth_access_grants_application_id", on_update: :no_action, on_delete: :no_action}
    t.string   "token",          null: false, index: {name: "index_oauth_access_grants_on_token", unique: true}
    t.integer  "expires_in",     null: false
    t.text     "redirect_uri",   null: false
    t.datetime "created_at",     null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id", index: {name: "fk__oauth_access_tokens_resource_owner_id"}, foreign_key: {references: "resource_owners", name: "fk_oauth_access_tokens_resource_owner_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "application_id",    index: {name: "fk__oauth_access_tokens_application_id"}, foreign_key: {references: "applications", name: "fk_oauth_access_tokens_application_id", on_update: :no_action, on_delete: :no_action}
    t.string   "token",             null: false, index: {name: "index_oauth_access_tokens_on_token", unique: true}
    t.string   "refresh_token",     index: {name: "index_oauth_access_tokens_on_refresh_token", unique: true}
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false, index: {name: "index_oauth_applications_on_uid", unique: true}
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
