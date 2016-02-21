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

ActiveRecord::Schema.define(version: 20160220142721) do

  PRAGMA FOREIGN_KEYS = ON;
  create_table "currencies", force: :cascade do |t|
    t.string   "prefix"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "full_name"
    t.string   "email"
    t.string   "facebook_id",         index: {name: "fk__users_facebook_id"}, foreign_key: {references: "facebooks", name: "fk_users_facebook_id", on_update: :no_action, on_delete: :no_action}
    t.string   "locale"
    t.integer  "timezone"
    t.string   "facebook_token"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "creator_id",          index: {name: "fk__groups_creator_id"}, foreign_key: {references: "users", name: "fk_groups_creator_id", on_update: :no_action, on_delete: :no_action}
    t.string   "status"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "bills", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "receipt_file_name"
    t.string   "receipt_content_type"
    t.integer  "receipt_file_size"
    t.datetime "receipt_updated_at"
    t.integer  "group_id",             index: {name: "index_bills_on_group_id"}, foreign_key: {references: "groups", name: "fk_bills_group_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "currency_id",          index: {name: "index_bills_on_currency_id"}, foreign_key: {references: "currencies", name: "fk_bills_currency_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "creator_id",           index: {name: "fk__bills_creator_id"}, foreign_key: {references: "users", name: "fk_bills_creator_id", on_update: :no_action, on_delete: :no_action}
    t.float    "amount"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "group_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "is_admin",   default: false
    t.integer  "user_id",    index: {name: "index_group_users_on_user_id"}, foreign_key: {references: "users", name: "fk_group_users_user_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "group_id",   index: {name: "index_group_users_on_group_id"}, foreign_key: {references: "groups", name: "fk_group_users_group_id", on_update: :no_action, on_delete: :no_action}
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
