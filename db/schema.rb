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

ActiveRecord::Schema.define(version: 20131007222455) do

  create_table "implementations", force: true do |t|
    t.integer  "user_id"
    t.integer  "patch_id"
    t.text     "source"
    t.integer  "score",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "implementations", ["patch_id"], name: "index_implementations_on_patch_id", using: :btree
  add_index "implementations", ["user_id"], name: "index_implementations_on_user_id", using: :btree

  create_table "patches", force: true do |t|
    t.integer  "user_id"
    t.string   "language"
    t.string   "name"
    t.string   "description"
    t.string   "tags"
    t.text     "tests"
    t.integer  "implementations_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "patches", ["language"], name: "index_patches_on_language", using: :btree
  add_index "patches", ["name"], name: "index_patches_on_name", using: :btree
  add_index "patches", ["tags"], name: "index_patches_on_tags", using: :btree
  add_index "patches", ["user_id"], name: "index_patches_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "score",                 default: 0
    t.integer  "patches_count",         default: 0
    t.integer  "implementations_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "implementation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["implementation_id"], name: "index_votes_on_implementation_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
