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

ActiveRecord::Schema.define(version: 20150508124823) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commits", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "repository_id"
    t.string   "message"
    t.string   "sha"
    t.string   "author"
    t.string   "email"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "branch_id"
    t.datetime "issued_at"
    t.integer  "additions",     default: 0
    t.integer  "deletions",     default: 0
    t.integer  "total_changes", default: 0
  end

  add_index "commits", ["branch_id"], name: "index_commits_on_branch_id", using: :btree
  add_index "commits", ["repository_id"], name: "index_commits_on_repository_id", using: :btree

  create_table "keys", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "space_id"
    t.integer  "repository_id"
    t.string   "resource_name"
    t.integer  "resource_id"
    t.string   "sha"
    t.string   "message"
    t.string   "annotation"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "cached_name"
  end

  add_index "notifications", ["repository_id"], name: "index_notifications_on_repository_id", using: :btree
  add_index "notifications", ["space_id", "repository_id"], name: "index_notifications_on_space_id_and_repository_id", using: :btree
  add_index "notifications", ["space_id"], name: "index_notifications_on_space_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "references", force: :cascade do |t|
    t.string   "type"
    t.integer  "repository_id"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "created_by_id"
  end

  add_index "references", ["type", "repository_id"], name: "index_references_on_type_and_repository_id", using: :btree
  add_index "references", ["type"], name: "index_references_on_type", using: :btree

  create_table "repositories", force: :cascade do |t|
    t.string   "name"
    t.string   "handle"
    t.string   "description"
    t.integer  "created_by_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "commits_count", default: 0
    t.integer  "space_id"
    t.string   "logo"
  end

  add_index "repositories", ["space_id", "handle"], name: "index_repositories_on_space_id_and_handle", unique: true, using: :btree
  add_index "repositories", ["space_id"], name: "index_repositories_on_space_id", using: :btree

  create_table "repository_users", force: :cascade do |t|
    t.integer  "repository_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "repository_users", ["repository_id", "user_id"], name: "index_repository_users_on_repository_id_and_user_id", unique: true, using: :btree

  create_table "spaces", force: :cascade do |t|
    t.string   "name"
    t.string   "handle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "spaces", ["handle"], name: "index_spaces_on_handle", unique: true, using: :btree

  create_table "user_repository_subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "repository_id"
    t.boolean  "email"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "user_repository_subscriptions", ["user_id", "repository_id"], name: "user_id_repository_id_subs", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "", null: false
    t.string   "full_name",              default: "", null: false
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
